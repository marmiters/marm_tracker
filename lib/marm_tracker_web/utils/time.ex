defmodule MarmTrackerWeb.Utils.Time do
  def decode_time(day_str) do
    {days, time} = calc_time(day_str)
    t_now = DateTime.utc_now |> DateTime.add(-time, :second) |> DateTime.to_naive
    {t_now, days}
  end

  defp calc_time(nil=_day_str), do: {7, 7*24*3600}
  defp calc_time(day_str) do
    with {days, _} <- day_str |> Integer.parse do
      {days, days*24*3600}
    else
      :error -> calc_time(nil)
    end
  end
end