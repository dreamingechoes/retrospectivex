defmodule Retrospectivex.Retrospectives.Schemas.Board do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Accounts.Schemas.User
  alias Retrospectivex.Retrospectives.Schemas.Card
  alias Retrospectivex.Retrospectives.Schemas.Team

  schema "boards" do
    field(:date, :naive_datetime)
    field(:description, :string)
    field(:max_votes, :integer, default: 0)
    field(:moderator, :string)
    field(:slug, :string)
    field(:state, BoardStateEnum)
    field(:title, :string)
    field(:uuid, :binary_id)

    timestamps()

    # Associations
    belongs_to(:team, Team)
    belongs_to(:user, User)
    has_many(:cards, Card, on_delete: :delete_all)
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [
      :title,
      :description,
      :state,
      :moderator,
      :date,
      :max_votes,
      :team_id,
      :user_id
    ])
    |> validate_required([:title, :state, :max_votes, :team_id, :user_id])
    |> validate_number(:max_votes, greater_than_or_equal_to: 0)
    |> cast_assoc(:team)
    |> cast_assoc(:user)
    |> generate_slug()
  end

  defp generate_slug(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        slug =
          title
          |> String.downcase()
          |> String.replace(" ", "-")

        put_change(current_changeset, :slug, slug)

      _ ->
        current_changeset
    end
  end
end
