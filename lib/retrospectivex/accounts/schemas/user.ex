defmodule Retrospectivex.Accounts.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field(:external_id, :string)
    field(:source, :integer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:source, :external_id])
    |> validate_required([:source, :external_id])
    |> unique_constraint(:external_id)
  end
end
