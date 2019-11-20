defmodule LivriApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :frequency, :string
    field :name, :string
    field :status, :string
    field :when, :date
    field :tags, :string
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :when, :frequency, :status, :tags])
    |> validate_required([:name, :when, :frequency, :status])
  end
end
