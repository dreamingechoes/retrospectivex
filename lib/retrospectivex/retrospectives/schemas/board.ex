defmodule Retrospectivex.Retrospectives.Schemas.Board do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Retrospectives.Schemas.Card

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

    has_many(:cards, Card, on_delete: :delete_all)
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :description, :state, :moderator, :date])
    |> validate_required([:title, :description, :state])
    |> validate_number(:max_votes, greater_than_or_equal_to: 0)
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
