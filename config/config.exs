# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :retrospectivex,
  ecto_repos: [Retrospectivex.Repo]

# Configures the endpoint
config :retrospectivex, RetrospectivexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "RkOdAtYCPvtnZeWnfCIinxC+XcTuPsVPz8T3hoEzgUjJp5s9NHl6dKbhMNDSdtc+",
  render_errors: [view: RetrospectivexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Retrospectivex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian configuration
config :retrospectivex, Retrospectivex.Guardian,
  issuer: "retrospectivex",
  secret_key: "eP/Fjhc5Ns4WsmYqBqwvC51oA0i/aXYeobBLn8V7Rrtyddfct48rimYbVQj28MAX"

config :retrospectivex, RetrospectivexWeb.AuthPipeline,
  module: RetrospectivexWeb.Guardian,
  error_handler: RetrospectivexWeb.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
