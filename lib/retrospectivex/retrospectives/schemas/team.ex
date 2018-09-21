defmodule Retrospectivex.Retrospectives.Schemas.Team do
  use Ecto.Schema

  import Ecto.Changeset

  schema "teams" do
    field(:description, :string)
    field(:name, :string)
    field(:members_list, :map)

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :description, :members_list])
    |> validate_required([:name])
  end
end
