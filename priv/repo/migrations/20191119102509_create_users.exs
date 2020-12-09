defmodule LivriApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users,
    primary_key: false,
    options: [
      provisioned_throughput: [1,1],
      global_indexes: [
        [index_name: "username",
          keys: [:username],
          provisioned_throughput: [1, 1]
        ]
      ]
    ]) do
      add :id, :string, primary_key: true
      add :username, :string
      add :password, :string
      add :document, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone, :string

      timestamps()
    end

  end
end
