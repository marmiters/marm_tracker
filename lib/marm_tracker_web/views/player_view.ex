defmodule MarmTrackerWeb.PlayerView do
  use MarmTrackerWeb, :view
  alias MarmTracker.Record

  def get_record_item(hs_map, skill, item) do
    hs_map[skill][item]
  end

  def get_diff(hs_list) do
    case hs_list do
    [] -> [["No records in this time period."]]
    _ -> first=List.first(hs_list) |> Map.from_struct
      last=List.last(hs_list) |> Map.from_struct
      Enum.reduce(Record.skills, [], fn x, acc ->
        acc ++ [
          [x |> Atom.to_string |> String.capitalize] ++
          #[last[x]["rank"]] ++
          #[last[x]["rank"] - first[x]["rank"]] ++
          [last[x]["level"] |> fmt_big_num] ++ # convert to string to avoid colourization
          [last[x]["level"] - first[x]["level"]] ++
          [last[x]["xp"] |> fmt_big_num] ++ # convert to string to avoid colourization
          [last[x]["xp"] - first[x]["xp"]] 
        ]
      end)
    end
  end

  def get_first_updated(hs_list) do
    case hs_list do
    [] -> "N/A"
    _ -> NaiveDateTime.diff(DateTime.utc_now |> DateTime.to_naive, last=List.first(hs_list).inserted_at) |> abs |> fmt_time_period
    end
  end
  def get_last_updated(hs_list) do
    case hs_list do
    [] -> "N/A"
    _ -> NaiveDateTime.diff(DateTime.utc_now |> DateTime.to_naive, last=List.last(hs_list).inserted_at) |> abs |> fmt_time_period
    end
  end

  defp fmt_time_period(int_seconds) do
    s_in_m = 60
    s_in_h = 60*s_in_m
    s_in_d = 24*s_in_h
    with days <- int_seconds |> div(s_in_d),
         hours <- (int_seconds-days*s_in_d) |> div(s_in_h),
         minutes <- (int_seconds-days*s_in_d-hours*s_in_h) |> div(s_in_m) do
      "#{days}d#{hours}h#{minutes}m"
    end
  end

  defp fmt_big_num(x) when is_integer(x) do
    Integer.to_string(x) |> slice_num
  end
  defp slice_num(a, acc \\ "") do
    len=String.length(a)
    if len<=3 do
      a <> acc
    else
      {s_start, s_end} = String.split_at(a, len-3)
      slice_num(s_start, "," <> s_end <> acc)
    end
  end

  def item_colour(a) when is_integer(a) do # TODO: Add config for colour values
    fade_perc=1
    low=60
    high=100
    cond do
      a>0 ->
        "color:hsl(" <> Integer.to_string(low + (high-low)*fade_perc) <> ", 73%, 50%)"
      true ->
        ""
    end
  end
  def item_colour(a), do: a

  def item_signify(a) when is_integer(a) do
    if a>0 do
      "+" <> fmt_big_num(a)
    else
      fmt_big_num(a)
    end
  end
  def item_signify(a), do: a

  @skillentry_class "text-right"
  @skillname_class "text-left"
  def item_classify(a) when is_integer(a) do
    @skillentry_class
  end
  def item_classify(a) do
    with {_integer, _} <- String.last(a) |> Integer.parse do
      @skillentry_class
    else
      :error -> @skillname_class
    end
  end

  def time_query_strings() do
    qs_param="&days="
    [
      %{:name => "Day", :qs => qs_param<>"1"},
      %{:name => "Week", :qs => ""},
      %{:name => "Month", :qs => qs_param<>"31"},
      %{:name => "Year", :qs => qs_param<>"365"}
    ]
  end
end