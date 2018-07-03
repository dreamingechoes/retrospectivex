defmodule Retrospectivex.Retrospectives.Schemas.Card do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Retrospectives.Schemas.Board

  schema "cards" do
    field(:body, :string)
    field(:title, :string)
    field(:votes, :integer)

    timestamps()

    belongs_to(:board, Board)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :body, :votes, :board_id])
    |> validate_required([:title, :body, :votes])
    |> cast_assoc(:board)
  end
end
