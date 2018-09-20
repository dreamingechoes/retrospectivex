defmodule Retrospectivex.Repo.Migrations.AddUserIdToRetrospectivesSchemas do
  use Ecto.Migration

  def change do
    alter table(:action_items) do
      add(:user_id, references(:users, on_delete: :delete_all))
    end

    alter table(:boards) do
      add(:user_id, references(:users, on_delete: :delete_all))
    end

    alter table(:cards) do
      add(:user_id, references(:users, on_delete: :delete_all))
    end

    create(index(:action_items, [:user_id]))
    create(index(:boards, [:user_id]))
    create(index(:cards, [:user_id]))
  end
end
