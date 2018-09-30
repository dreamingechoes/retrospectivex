defmodule RetrospectivexWeb.OAuth.AuthController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Accounts

  def index(conn, %{"provider" => provider}) do
    redirect(conn, external: authorize_url!(provider))
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :index))
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = get_token!(provider, code)

    user = get_user!(provider, client)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: dashboard_path(conn, :index))
  end

  defp authorize_url!("github"), do: GitHub.authorize_url!()

  defp authorize_url!("google"),
    do:
      Google.authorize_url!(
        scope: "https://www.googleapis.com/auth/userinfo.email"
      )

  defp get_token!("github", code), do: GitHub.get_token!(code: code)
  defp get_token!("google", code), do: Google.get_token!(code: code)

  defp get_user!("github", client) do
    %{body: github_user} = OAuth2.Client.get!(client, "/user")

    user =
      Accounts.get_or_create_user_by_external_id(github_user["id"], :github)

    %{
      id: user.id,
      name: github_user["name"],
      avatar: github_user["avatar_url"],
      email: github_user["email"]
    }
  end

  defp get_user!("google", client) do
    %{body: google_user} =
      OAuth2.Client.get!(
        client,
        "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
      )

    user =
      Accounts.get_or_create_user_by_external_id(google_user["sub"], :google)

    %{
      id: user.id,
      name: google_user["name"],
      avatar: google_user["picture"],
      email: google_user["email"]
    }
  end
end
