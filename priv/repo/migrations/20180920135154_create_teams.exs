defmodule Retrospectivex.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:description, :text)
      add(:members_list, {:array, :string})
      add(:name, :string, null: false)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end

    create(index(:teams, [:user_id]))
  end
end
