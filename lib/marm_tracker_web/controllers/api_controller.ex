defmodule MarmTrackerWeb.ApiController do
  use MarmTrackerWeb, :controller
  alias MarmTracker.{Repo, Player, Record}
  alias MarmTrackerWeb.Utils
  import Ecto.Query

  # /api/one
  # params:
  #   rsn -> player's name, underscores are acceptable as spaces
  #   skill -> index of skill, according to rs hiscores (0 is overall, 1 is attack, etc)
  #   optional:days -> number of days in the past from now
  # returns csv data with ISO8601 formatted date and skill xp in each row
  def get_timeseries_one(conn, %{"rsn" => rsn, "skill" => skill} = params) do
    {t_now, _days} = Utils.Time.decode_time(params["days"])
    rsn = rsn |> String.trim
    {skill, _} = Integer.parse(skill)
    skill = Enum.at(Record.skills, skill)

    query = from p in Player, where: p.rsn == ^rsn
    with %Player{} = player <- Repo.one(query) do
      records = "records"
        |> where([r], r.player_id == ^player.id and r.inserted_at > ^t_now)
        |> select(^[:inserted_at, skill])
        |> order_by([:inserted_at])
        |> Repo.all()
      records = Enum.map(records, fn (x) -> {x[:inserted_at], x[skill]} end)
      send_csv(conn, records)
    else
      nil -> text(conn, "error")
    end
  end

  defp send_csv(conn, data) do
    csv = data
    |> Enum.map(fn ({t,e} = _x) -> {NaiveDateTime.to_iso8601(t), to_string(e["xp"])} end)
    |> Enum.map(fn ({t,e} = _x) -> t <> "," <> e end)
    |> Enum.reduce(fn (line, acc) -> acc <> "\n" <> line end)
    conn
    |> put_resp_header("content-type", "text/csv; charset=utf-8")
    |> send_resp(200, csv)
  end
end