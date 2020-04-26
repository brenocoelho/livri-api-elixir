defmodule LivriApp.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags, 
    primary_key: false,
    options: [
      provisioned_throughput: [1,1]
    ]) do
      add :user_id, :string, primary_key: true
      add :id, :string, range_key: true
      add :name, :string
      add :color, :string
      add :priority, :integer

      timestamps()
    end

    # create index(:tags, [:user_id])
  end
end
