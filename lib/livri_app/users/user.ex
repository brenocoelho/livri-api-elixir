defmodule LivriApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Argon2

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :document, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :username, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:document, :username, :first_name, :last_name, :email, :phone, :password])
    |> validate_required([:document, :username, :first_name, :last_name, :email, :phone])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

end
