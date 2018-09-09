defmodule RetrospectivexWeb.OAuth.AuthController do
  use RetrospectivexWeb, :controller

  def index(conn, %{"provider" => provider}) do
    redirect(conn, external: authorize_url!(provider))
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = get_token!(provider, code)

    user = get_user!(provider, client)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
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
    %{body: user} = OAuth2.Client.get!(client, "/user")

    %{name: user["name"], avatar: user["avatar_url"]}
  end

  defp get_user!("google", client) do
    %{body: user} =
      OAuth2.Client.get!(
        client,
        "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
      )

    %{name: user["name"], avatar: user["picture"]}
  end
end
