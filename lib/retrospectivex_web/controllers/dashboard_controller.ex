defmodule RetrospectivexWeb.DashboardController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Accounts

  def index(conn = %{assigns: %{current_user: %{id: id}}}, _params) do
    user = Accounts.get_user!(id)

    render(conn, "index.html", teams: user.teams)
  end
end
