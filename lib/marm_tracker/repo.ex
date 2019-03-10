defmodule MarmTracker.Repo do
  use Ecto.Repo,
    otp_app: :marm_tracker,
    adapter: Ecto.Adapters.Postgres
end
