defmodule Retrospectivex.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:source, :integer)
      add(:external_id, :string, unique: true)

      timestamps()
    end
  end
end
