defmodule Retrospectivex.Retrospectives.Schemas.Card do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Accounts.Schemas.User
  alias Retrospectivex.Retrospectives.Schemas.Board

  schema "cards" do
    field(:body, :string)
    field(:kind, CardKindEnum)
    field(:title, :string)
    field(:votes, :integer, default: 0)

    timestamps()

    # Associations
    belongs_to(:board, Board)
    belongs_to(:user, User)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :body, :votes, :kind, :board_id, :user_id])
    |> validate_required([:title, :board_id])
    |> cast_assoc(:board)
    |> cast_assoc(:user)
  end
end
