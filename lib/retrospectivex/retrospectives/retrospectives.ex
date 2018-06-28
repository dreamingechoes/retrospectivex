defmodule Retrospectivex.Retrospectives do
  @moduledoc """
  The Retrospectives context.
  """

  alias Retrospectivex.Retrospectives.Managers.Board, as: BoardManager

  # Board API
  defdelegate list_boards, to: BoardManager
  defdelegate get_board!(id), to: BoardManager
  defdelegate create_board(attrs), to: BoardManager
  defdelegate update_board(board, attrs), to: BoardManager
  defdelegate delete_board(board), to: BoardManager
  defdelegate change_board(board), to: BoardManager
end
