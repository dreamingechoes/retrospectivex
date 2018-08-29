defmodule Retrospectivex.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add(:body, :text)
      add(:seo_info, :map)
      add(:slug, :text)
      add(:state, :integer)
      add(:title, :text)

      timestamps()
    end

    create(unique_index(:pages, [:title]))
  end
end
