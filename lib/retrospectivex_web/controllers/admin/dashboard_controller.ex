defmodule RetrospectivexWeb.Admin.DashboardController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Accounts.Schemas.Administrator
  alias Retrospectivex.Contents.Schemas.Page
  alias Retrospectivex.Retrospectives.Board
  alias Retrospectivex.Repo

  def index(conn, _params) do
    with administrators <- Repo.aggregate(Administrator, :count, :id),
         boards <- Repo.aggregate(Board, :count, :id),
         pages <- Repo.aggregate(Page, :count, :id) do
      render(
        conn,
        "index.html",
        administrators: administrators,
        boards: boards,
        pages: pages
      )
    end
  end
end
