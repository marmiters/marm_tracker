defmodule MarmTracker.Record do
  use Ecto.Schema
  import Ecto.Changeset

  alias MarmTracker.Player

    @skill_names [
      :total,
      :attack,
      :defence,
      :strength,
      :hitpoints,
      :ranged,
      :prayer,
      :magic,
      :cooking,
      :woodcutting,
      :fletching,
      :fishing,
      :firemaking,
      :crafting,
      :smithing,
      :mining,
      :herblore,
      :agility,
      :thieving,
      :slayer,
      :farming,
      :runecraft,
      :hunter,
      :construction
    ]

  def skills() do
    @skill_names
  end

  schema "records" do
    field :agility, {:map, :integer}, null: false
    field :attack, {:map, :integer}, null: false
    field :construction, {:map, :integer}, null: false
    field :cooking, {:map, :integer}, null: false
    field :crafting, {:map, :integer}, null: false
    field :defence, {:map, :integer}, null: false
    field :farming, {:map, :integer}, null: false
    field :firemaking, {:map, :integer}, null: false
    field :fishing, {:map, :integer}, null: false
    field :fletching, {:map, :integer}, null: false
    field :herblore, {:map, :integer}, null: false
    field :hitpoints, {:map, :integer}, null: false
    field :hunter, {:map, :integer}, null: false
    field :magic, {:map, :integer}, null: false
    field :mining, {:map, :integer}, null: false
    field :prayer, {:map, :integer}, null: false
    field :ranged, {:map, :integer}, null: false
    field :runecraft, {:map, :integer}, null: false
    field :slayer, {:map, :integer}, null: false
    field :smithing, {:map, :integer}, null: false
    field :strength, {:map, :integer}, null: false
    field :thieving, {:map, :integer}, null: false
    field :total, {:map, :integer}, null: false
    field :woodcutting, {:map, :integer}, null: false
    belongs_to(:player, Player)
    timestamps()
  end

  @doc false
  def changeset(record, attrs) do
    record
    |> cast(attrs, [:total, :attack, :defence, :strength, :hitpoints, :ranged, :prayer, :magic, :cooking, :woodcutting, :fletching, :fishing, :firemaking, :crafting, :smithing, :mining, :herblore, :agility, :thieving, :slayer, :farming, :runecraft, :hunter, :construction])
    |> validate_required([:total, :attack, :defence, :strength, :hitpoints, :ranged, :prayer, :magic, :cooking, :woodcutting, :fletching, :fishing, :firemaking, :crafting, :smithing, :mining, :herblore, :agility, :thieving, :slayer, :farming, :runecraft, :hunter, :construction])
  end
end
