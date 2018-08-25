defmodule RetrospectivexWeb.Frankt.Retrospectives.Board do
  use RetrospectivexWeb, :frankt

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Board
  alias RetrospectivexWeb.Board.Component.ShowView, as: ShowComponentView
  alias RetrospectivexWeb.BoardView

  def filter_cards(
        %{"card_filters" => card_filters = %{"board_id" => board_id}},
        socket
      ) do
    board = Retrospectives.get_board!(board_id, card_filters)
    update_stacks(board, socket)
  end

  def delete_modal(%{"board_id" => board_id}, socket) do
    html =
      render(
        socket,
        ShowComponentView,
        "_delete_modal.html",
        board_id: board_id
      )

    push(socket, "open_modal", %{html: html})
  end

  def delete(%{"board_id" => board_id}, socket) do
    board = Retrospectives.get_board!(board_id)

    case Retrospectives.delete_board(board) do
      {:ok, _board} ->
        push(socket, "close_modal", %{})

      _error ->
        nil
    end
  end

  defp update_stacks(board, socket) do
    push(socket, "replace_with", %{
      target: "#board-stacks",
      html:
        render(
          socket,
          ShowComponentView,
          "_board_stacks.html",
          conn: %Plug.Conn{},
          board: board
        )
    })

    push(socket, "setup_accordion", %{})
  end
end
