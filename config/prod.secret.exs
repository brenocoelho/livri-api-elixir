# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

# config :livri_app, LivriApp.Repo,
#   ssl: true,
#   url: database_url,
#   pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

aws_access_key_id =
  System.get_env("AWS_ACCESS_KEY_ID") ||
    raise """
    environment variable AWS_ACCESS_KEY_ID is missing.
    """

aws_secret_access_key =
  System.get_env("AWS_SECRET_ACCESS_KEY") ||
    raise """
    environment variable AWS_SECRET_ACCESS_KEY is missing.
    """

aws_region =
  System.get_env("AWS_REGION") ||
    raise """
    environment variable AWS_REGION is missing.
    """

config :livri_app, LivriApp.Repo,
  # ExAws configuration
  access_key_id: aws_access_key_id,
  secret_access_key: aws_secret_access_key,
  region: aws_region  

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :livri_app, LivriAppWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :livri_app, LivriAppWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
