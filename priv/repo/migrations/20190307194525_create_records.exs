defmodule MarmTracker.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :total, {:map, :integer}
      add :attack, {:map, :integer}
      add :defence, {:map, :integer}
      add :strength, {:map, :integer}
      add :hitpoints, {:map, :integer}
      add :ranged, {:map, :integer}
      add :prayer, {:map, :integer}
      add :magic, {:map, :integer}
      add :cooking, {:map, :integer}
      add :woodcutting, {:map, :integer}
      add :fishing, {:map, :integer}
      add :firemaking, {:map, :integer}
      add :fletching, {:map, :integer}
      add :crafting, {:map, :integer}
      add :smithing, {:map, :integer}
      add :mining, {:map, :integer}
      add :herblore, {:map, :integer}
      add :agility, {:map, :integer}
      add :thieving, {:map, :integer}
      add :slayer, {:map, :integer}
      add :farming, {:map, :integer}
      add :runecraft, {:map, :integer}
      add :hunter, {:map, :integer}
      add :construction, {:map, :integer}
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:records, [:player_id])
  end
end
