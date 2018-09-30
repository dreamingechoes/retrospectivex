defmodule Retrospectivex.Repo.Migrations.AddTeamIdToBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add(:team_id, references(:teams, on_delete: :delete_all))
    end

    create(index(:boards, [:team_id]))
  end
end
