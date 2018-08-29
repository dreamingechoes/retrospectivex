defmodule Retrospectivex.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add(:board_id, references(:boards, on_delete: :delete_all))
      add(:body, :text)
      add(:title, :text)
      add(:votes, :integer)

      timestamps()
    end

    create(index(:cards, [:board_id]))
  end
end
