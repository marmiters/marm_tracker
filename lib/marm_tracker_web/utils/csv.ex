defmodule MarmTrackerWeb.Utils.Csv do
  alias MarmTracker.Record

  def read_csv(raw_csv) do
    data = String.split(raw_csv, "\n") |> Enum.map(fn s -> String.split(s, ",") end)
    individual_maps = Enum.map(data, fn x -> %{:rank => Enum.at(x, 0), :level => Enum.at(x, 1), :xp => Enum.at(x, 2)} end)
    Enum.zip(Record.skills, individual_maps) |> Enum.into(%{})
  end
end