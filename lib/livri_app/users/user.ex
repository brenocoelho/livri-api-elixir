defmodule LivriApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :digital_hash, :string
    field :document, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:document, :username, :first_name, :last_name, :email, :phone, :digital_hash])
    |> validate_required([:document, :username, :first_name, :last_name, :email, :phone, :digital_hash])
  end
end
