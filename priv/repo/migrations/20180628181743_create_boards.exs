defmodule Retrospectivex.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add(:description, :text)
      add(:slug, :text)
      add(:state, :integer, null: false)
      add(:title, :text, null: false)
      add(:uuid, :uuid, default: fragment("uuid_generate_v4()"))

      timestamps()
    end
  end
end
