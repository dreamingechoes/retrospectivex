defmodule Retrospectivex.Repo.Migrations.AddModeratorAndDateToBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add(:date, :naive_datetime)
      add(:moderator, :string)
    end
  end
end
