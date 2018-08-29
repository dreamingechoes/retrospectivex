defmodule Retrospectivex.Repo.Migrations.CreateActionItems do
  use Ecto.Migration

  def change do
    create table(:action_items) do
      add(:body, :text)
      add(:card_id, references(:cards, on_delete: :delete_all))
      add(:state, :integer)
      add(:responsible, :string)
      add(:title, :text)

      timestamps()
    end

    create(index(:action_items, [:card_id]))
  end
end
