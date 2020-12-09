defmodule LivriApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, 
    primary_key: false,
    options: [
      provisioned_throughput: [1,1]
    ]) do
      add :user_id, :string, primary_key: true
      add :id, :string, range_key: true
      add :name, :string
      add :detail, :string
      add :due_date, :string
      add :frequency, :string
      add :status, :string
      add :tags, :string

      timestamps()
    end

    # create index(:tasks, [:user_id])
  end
end
