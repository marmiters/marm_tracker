defmodule MarmTracker.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION citext", "DROP EXTENSION citext"
    create table(:players) do
      add :rsn, :citext, null: false
      add :prev_rsn, :citext, null: true

      timestamps()
    end

  end
end
