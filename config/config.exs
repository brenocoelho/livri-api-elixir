# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :livri_app,
  ecto_repos: [LivriApp.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :livri_app, LivriAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V/XGQWtHwLRkO2DQ40s2RPR0m7l6fFkmaChfSY6scgUHdf9pUw7ig2HSEuVyivpw",
  render_errors: [view: LivriAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LivriApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian
config :livri_app, LivriApp.Users.Guardian,
  issuer: "livri.io",
  secret_key: "K5zSmPCl9zEzQssgk+SfDNhPA9rkaA5R1aY2j+5rJXLe+BrVDv3MmelK5mGr3CHf"

# config :livri_app, LivriApp.Users.AuthAccessPipeline,
#   module: LivriApp.Users.Guardian,
#   error_handler: LivriApp.Users.AuthErrorHandler


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
