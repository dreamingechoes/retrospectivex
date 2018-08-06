defmodule RetrospectivexWeb.BoardController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Board

  def new(conn, _params) do
    changeset = Retrospectives.change_board(%Board{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{
        "board" => board_params,
        "g-recaptcha-response" => g_recaptcha_response
      }) do
    case Recaptcha.verify(g_recaptcha_response) do
      {:ok, _response} ->
        case Retrospectives.create_board(board_params) do
          {:ok, %{id: board_id}} ->
            # We need to reload the board in order to have available the auto-generated
            # 'uuid' field to execute the proper redirection.
            board = Retrospectives.get_board!(board_id)

            conn
            |> put_flash(:info, "Board created successfully.")
            |> redirect(to: board_path(conn, :show, board.slug, [u: board.uuid]))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
        end

      {:error, _error} ->
        render(
          conn,
          "new.html",
          changeset: Retrospectives.change_board(%Board{})
        )
    end
  end

  def show(conn, %{"slug" => slug, "u" => uuid}) do
    board = Retrospectives.get_board_by_slug_and_uuid!(slug, uuid)
    render(conn, "show.html", board: board)
  end
end
