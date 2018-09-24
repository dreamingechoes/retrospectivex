defmodule RetrospectivexWeb.Contents.PageController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Contents

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"slug" => slug}) do
    page = Contents.get_page_by_slug!(slug)
    render(conn, "show.html", page: page)
  end
end
