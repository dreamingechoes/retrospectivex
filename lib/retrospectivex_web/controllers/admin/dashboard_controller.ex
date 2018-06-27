defmodule RetrospectivexWeb.Admin.DashboardController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Accounts.Administrator
  alias Retrospectivex.Repo

  def index(conn, _params) do
    with administrators <- Repo.aggregate(Administrator, :count, :id) do
      render(conn, "index.html", administrators: administrators)
    end
  end
end
