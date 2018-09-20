defmodule Retrospectivex.Repo.Migrations.AddMaxVotesToBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add(:max_votes, :integer, default: 0, null: false)
    end
  end
end
