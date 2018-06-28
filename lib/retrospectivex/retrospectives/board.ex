defmodule Retrospectivex.Retrospectives.Board do
  use Ecto.Schema

  import Ecto.Changeset

  schema "boards" do
    field(:description, :string)
    field(:slug, :string)
    field(:status, BoardStatusEnum)
    field(:title, :string)
    field(:uuid, :binary_id)

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([:title, :description, :status])
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
