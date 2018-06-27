defmodule RetrospectivexWeb.SessionController do
  alias Retrospectivex.Guardian
  alias Retrospectivex.Guardian.Plug

  use RetrospectivexWeb, :controller

  plug(:put_layout, {RetrospectivexWeb.Admin.LayoutView, "admin_auth.html"})

  def new(conn, _), do: render(conn, "new.html")

  def create(conn, %{
        "session" => %{
          "email" => email,
          "password" => password
        }
      }) do
    case Guardian.authenticate_administrator(email, password) do
      {:ok, administrator} ->
        conn
        |> Plug.sign_in(administrator)
        |> put_flash(:success, gettext("Welcome to Retroxpectivex!"))
        |> redirect(to: page_path(conn, :index))

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> Plug.sign_out()
    |> redirect(to: page_path(conn, :index))
  end
end
