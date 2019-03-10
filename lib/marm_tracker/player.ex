defmodule MarmTracker.Player do
  use Ecto.Schema
  import Ecto.Changeset


  schema "players" do
    field :prev_rsn, :string
    field :rsn, :string
    has_many(:record, MarmTracker.Record, on_delete: :delete_all)
    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:rsn, :prev_rsn])
    |> validate_required([:rsn])
    |> validate_length(:rsn, min: 1, max: 12)
    |> validate_length(:prev_rsn, min: 1, max: 12)
    |> unique_constraint(:rsn)
  end
end
