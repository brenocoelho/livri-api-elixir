defmodule LivriApp.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :user_id, :binary_id, primary_key: true
    field :color, :string
    field :name, :string
    field :priority, :integer

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:user_id, :name, :color, :priority])
    |> validate_required([:user_id, :name, :color, :priority])
  end
end
