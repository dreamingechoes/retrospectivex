defmodule Retrospectivex.Repo.Migrations.CreateAdministrators do
  use Ecto.Migration

  def change do
    create table(:administrators) do
      add(:first_name, :string)
      add(:last_name, :string)
      add(:email, :string)
      add(:encrypted_password, :string)

      timestamps()
    end

    create(unique_index(:administrators, [:email]))
  end
end
