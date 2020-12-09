defmodule LivriApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :user_id, :binary_id, primary_key: true
    field :name, :string
    field :detail, :string
    field :due_date, :string
    field :frequency, :string
    field :tags, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:user_id, :name, :detail, :due_date, :frequency, :status, :tags])
    |> validate_required([:user_id, :name, :due_date, :frequency, :status])
  end
end
