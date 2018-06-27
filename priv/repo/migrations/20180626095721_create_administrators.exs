defmodule Retrospectivex.Repo.Migrations.CreateAdministrators do
  use Ecto.Migration

  def change do
    create table(:administrators) do
      add(:email, :string)
      add(:encrypted_password, :string)
      add(:first_name, :string)
      add(:last_name, :string)

      timestamps()
    end

    create(unique_index(:administrators, [:email]))
  end
end
