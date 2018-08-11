defmodule Retrospectivex.Repo.Migrations.AddKindToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add(:kind, :integer)
    end
  end
end
