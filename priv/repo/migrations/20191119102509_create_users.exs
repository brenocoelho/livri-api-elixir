defmodule LivriApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :document, :string
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone, :string
      add :digital_hash, :string

      timestamps()
    end

  end
end
