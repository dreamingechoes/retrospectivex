defmodule Retrospectivex.Retrospectives.Schemas.Card do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Retrospectives.Schemas.Board

  schema "cards" do
    field(:body, :string)
    field(:kind, CardKindEnum)
    field(:title, :string)
    field(:votes, :integer, default: 0)

    timestamps()

    belongs_to(:board, Board)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :body, :votes, :kind, :board_id])
    |> validate_required([:title, :board_id])
    |> cast_assoc(:board)
  end
end
