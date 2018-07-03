defmodule Retrospectivex.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add(:body, :text)
      add(:title, :text)
      add(:votes, :integer)
      add(:board_id, references(:boards, on_delete: :delete_all))

      timestamps()
    end

    create(index(:cards, [:board_id]))
  end
end
