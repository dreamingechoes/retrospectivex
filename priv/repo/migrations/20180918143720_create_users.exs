defmodule Retrospectivex.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:source, :integer, null: false)
      add(:external_id, :string, unique: true, null: false)

      timestamps()
    end
  end
end
