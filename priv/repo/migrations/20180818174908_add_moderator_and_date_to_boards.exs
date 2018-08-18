defmodule Retrospectivex.Repo.Migrations.AddModeratorAndDateToBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add(:moderator, :string)
      add(:date, :naive_datetime)
    end
  end
end
