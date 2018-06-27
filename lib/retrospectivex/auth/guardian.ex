defmodule Retrospectivex.Guardian do
  use Guardian, otp_app: :retrospectivex

  import RetrospectivexWeb.Gettext

  alias Comeonin.Bcrypt
  alias Retrospectivex.Accounts

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    resource = Accounts.get_administrator!(id)
    {:ok, resource}
  end

  def authenticate_administrator(email, password) do
    email
    |> Accounts.get_administrator_by_email()
    |> check_password(password)
  end

  defp check_password(nil, _),
    do: {:error, gettext("Incorrect username or password")}

  defp check_password(administrator, password) do
    case Bcrypt.checkpw(password, administrator.encrypted_password) do
      true -> {:ok, administrator}
      false -> {:error, gettext("Incorrect username or password")}
    end
  end
end
