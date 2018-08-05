defmodule Retrospectivex.Contents.Schemas.Page do
  use Ecto.Schema

  import Ecto.Changeset

  alias Retrospectivex.Contents.Schemas.Embedded.SeoInfo

  schema "pages" do
    field(:body, :string)
    field(:slug, :string)
    field(:status, PageStatusEnum)
    field(:title, :string)

    timestamps()

    embeds_one(:seo_info, SeoInfo, on_replace: :update)
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:title, :slug, :status, :body])
    |> validate_required([:title])
    |> unique_constraint(:title)
    |> cast_embed(:seo_info)
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
