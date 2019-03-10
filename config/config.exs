# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :marm_tracker,
  ecto_repos: [MarmTracker.Repo]

# Configures the endpoint
config :marm_tracker, MarmTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kqMQ5pwWhpsU7zpwNz1AErelikqrKzwCWxctmVLSyo4VaS6vAWu8MrhVfb66y38X",
  render_errors: [view: MarmTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MarmTracker.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
