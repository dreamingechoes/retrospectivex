defmodule Retrospectivex.Repo.Migrations.CreateAdministrators do
  use Ecto.Migration

  def change do
    create table(:administrators) do
      add(:email, :string, null: false)
      add(:encrypted_password, :string, null: false)
      add(:first_name, :string, null: false)
      add(:last_name, :string, null: false)

      timestamps()
    end

    create(unique_index(:administrators, [:email]))
  end
end
