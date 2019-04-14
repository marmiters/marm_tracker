defmodule MarmTrackerWeb.PlayerController do
  use MarmTrackerWeb, :controller
  alias MarmTracker.{Repo, Player, Record}
  alias MarmTrackerWeb.Utils
  import Ecto.Query, only: [from: 2]

  def index(conn, %{"rsn" => rsn} = params) do
    update_path = current_path(conn) |> String.replace("player", "update")
    path_without_time = "/player?" <> (params |> Map.drop(["days"]) |> URI.encode_query)
    {t_now, days} = Utils.Time.decode_time(params["days"])
    rsn = rsn |> String.trim

    query = from p in Player, where: p.rsn == ^rsn
    with %Player{} = player <- Repo.one(query) do
      query = from r in Record,
        where: r.player_id == ^player.id and r.inserted_at > ^t_now,
        order_by: r.inserted_at
      conn
      |> assign(:rsn, rsn)
      |> assign(:update_path, update_path)
      |> assign(:path_without_time, path_without_time)
      |> assign(:days, days)
      |> assign(:records, Repo.all(query))
      |> render("index.html")
    else
      nil -> conn
      |> assign(:rsn, rsn)
      |> assign(:update_path, update_path)
      |> render("not_found.html")
    end
  end

  # Multiple steps
  # 1. Gather arguments
  # 2. Get player from RS Hiscores API
  # 3. If valid player, check if already in DB, otherwise skip to return failure
  # 3a. If not in DB, add player to DB
  # 3b. If in DB, do nothing
  # 4. Insert results from Hiscores API
  # 5. Return success
  def update(conn, %{"rsn" => rsn}) do
    require Logger
    # Get from hiscores
    base_url = "https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?"
    query_string = URI.encode_query(player: rsn)
    hiscores_url = base_url <> query_string
    hs_map = with {:ok, hs} <- HTTPoison.get(hiscores_url) do
      Utils.Csv.read_csv(hs.body)
    end
    # only push to db if valid response from hiscores api
    if (hs_map.attack.level |> Integer.parse) != :error do
      push_to_db(rsn, hs_map)
    end
    redirect_path = current_path(conn)
    |> String.replace("update", "player")
    conn
    |> redirect(to: redirect_path)
  end

  defp push_to_db(player_name, %{} = new_record) do
    player = with %Player{} = player <- Repo.get_by(Player, rsn: player_name) do
      player
    else
      _not_found -> cs = Player.changeset(%Player{}, %{rsn: player_name})
      {:ok, player} = Repo.insert(cs)
      player
    end
    Ecto.build_assoc(player, :record)
    |> Record.changeset(new_record)
    |> Repo.insert
  end

end
