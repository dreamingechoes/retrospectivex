defmodule Retrospectivex.Retrospectives.Schemas.Team do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Accounts.Schemas.User
  alias Retrospectivex.Retrospectives.Schemas.Board

  schema "teams" do
    field(:description, :string)
    field(:name, :string)
    field(:members_list, {:array, :string})

    timestamps()

    # Associations
    belongs_to(:user, User)
    has_many(:boards, Board, on_delete: :delete_all)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :description, :members_list, :user_id])
    |> validate_required([:name, :user_id])
    |> cast_assoc(:user)
  end
end
