defmodule LivriApp.Repo do
  use Ecto.Repo,
    otp_app: :livri_app,
    adapter: Ecto.Adapters.DynamoDB
end
