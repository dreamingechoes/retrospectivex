defmodule Retrospectivex.Retrospectives do
  @moduledoc """
  The Retrospectives context.
  """

  alias Retrospectivex.Retrospectives.Managers.ActionItem, as: ActionItemManager
  alias Retrospectivex.Retrospectives.Managers.Board, as: BoardManager
  alias Retrospectivex.Retrospectives.Managers.Card, as: CardManager

  # ActionItem API
  defdelegate change_action_item(action_item), to: ActionItemManager
  defdelegate create_action_item(attrs), to: ActionItemManager
  defdelegate delete_action_item(action_item), to: ActionItemManager
  defdelegate get_action_item!(id), to: ActionItemManager
  defdelegate list_action_items, to: ActionItemManager
  defdelegate list_action_items_by_board(board), to: ActionItemManager
  defdelegate update_action_item(action_item, attrs), to: ActionItemManager

  # Board API
  defdelegate change_board(board), to: BoardManager
  defdelegate create_board(attrs), to: BoardManager
  defdelegate delete_board(board), to: BoardManager
  defdelegate get_board_by_slug_and_uuid!(slug, uuid), to: BoardManager
  defdelegate get_board!(id), to: BoardManager
  defdelegate get_board!(id, filter_cards), to: BoardManager
  defdelegate list_boards, to: BoardManager
  defdelegate update_board(board, attrs), to: BoardManager

  # Card API
  defdelegate change_card(card), to: CardManager
  defdelegate create_card(attrs), to: CardManager
  defdelegate delete_card(card), to: CardManager
  defdelegate get_card!(id), to: CardManager
  defdelegate list_cards, to: CardManager
  defdelegate update_card(card, attrs), to: CardManager
end
