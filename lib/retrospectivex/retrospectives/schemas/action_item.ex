defmodule Retrospectivex.Retrospectives.Schemas.ActionItem do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Retrospectives.Schemas.Card

  schema "action_items" do
    field(:body, :string)
    field(:responsible, :string)
    field(:state, ActionItemStateEnum)
    field(:title, :string)

    timestamps()

    belongs_to(:card, Card)
  end

  @doc false
  def changeset(action_item, attrs) do
    action_item
    |> cast(attrs, [:title, :body, :state, :responsible])
    |> validate_required([:title])
    |> cast_assoc(:card)
  end
end
