defmodule Retrospectivex.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:name, :string, null: false)
      add(:description, :text)
      add(:members_list, :map)

      timestamps()
    end
  end
end
