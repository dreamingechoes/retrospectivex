defmodule RetrospectivexWeb.BoardController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Retrospectives

  def show(conn, %{"slug" => slug, "u" => uuid}) do
    board = Retrospectives.get_board_by_slug_and_uuid!(slug, uuid)
    render(conn, "show.html", board: board)
  end
end
