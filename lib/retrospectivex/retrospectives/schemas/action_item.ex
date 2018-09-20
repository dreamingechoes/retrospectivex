defmodule Retrospectivex.Retrospectives.Schemas.ActionItem do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Accounts.Schemas.User
  alias Retrospectivex.Retrospectives.Schemas.Card

  schema "action_items" do
    field(:body, :string)
    field(:responsible, :string)
    field(:state, ActionItemStateEnum)
    field(:title, :string)

    timestamps()

    # Associations
    belongs_to(:card, Card)
    belongs_to(:user, User)
  end

  @doc false
  def changeset(action_item, attrs) do
    action_item
    |> cast(attrs, [:title, :body, :state, :responsible, :card_id, :user_id])
    |> validate_required([:title])
    |> cast_assoc(:card)
    |> cast_assoc(:user)
  end
end
