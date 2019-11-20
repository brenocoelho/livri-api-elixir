defmodule LivriApp.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :color, :string
    field :name, :string
    field :priority, :integer
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :color, :priority])
    |> validate_required([:name, :color, :priority])
  end
end
