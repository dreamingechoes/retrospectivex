defmodule Retrospectivex.Accounts.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Retrospectives.Schemas.ActionItem
  alias Retrospectivex.Retrospectives.Schemas.Board
  alias Retrospectivex.Retrospectives.Schemas.Card
  alias Retrospectivex.Retrospectives.Schemas.Team

  schema "users" do
    field(:external_id, :string)
    field(:source, UserSourceEnum)

    timestamps()

    # Associations
    has_many(:boards, Board, on_delete: :delete_all)
    has_many(:cards, Card, on_delete: :delete_all)
    has_many(:action_items, ActionItem, on_delete: :delete_all)
    has_many(:teams, Team, on_delete: :delete_all)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:source, :external_id])
    |> validate_required([:source, :external_id])
    |> unique_constraint(:external_id)
  end
end
