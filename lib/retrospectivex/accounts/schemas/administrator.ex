defmodule Retrospectivex.Accounts.Schemas.Administrator do
  use Ecto.Schema

  import Ecto.Changeset

  schema "administrators" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:encrypted_password, :string)
    field(:password, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(administrator, attrs) do
    administrator
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email, :password])
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> generate_encrypted_password()
  end

  defp generate_encrypted_password(%Ecto.Changeset{valid?: true} = changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        put_change(
          changeset,
          :encrypted_password,
          Comeonin.Bcrypt.hashpwsalt(password)
        )
    end
  end

  defp generate_encrypted_password(changeset), do: changeset
end
