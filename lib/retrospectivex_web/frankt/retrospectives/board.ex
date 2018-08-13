defmodule RetrospectivexWeb.Frankt.Retrospectives.Board do
  use RetrospectivexWeb, :frankt

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Card
  alias RetrospectivexWeb.Board.Component.ShowView, as: ShowComponentView
  alias RetrospectivexWeb.CardView

  def create_card_modal(%{"board_id" => board_id, "kind" => kind}, socket) do
    html =
      render(
        socket,
        CardView,
        "form.html",
        changeset:
          Retrospectives.change_card(%Card{board_id: board_id, kind: kind})
      )

    push(socket, "open_modal", %{html: html})
    push(socket, "activate_codemirror", %{})
  end

  def create_card(%{"card_params" => card_params = %{"kind" => kind}}, socket) do
    push(socket, "close_modal", %{})

    case Retrospectives.create_card(card_params) do
      {:ok, card} ->
        update_card_deck(kind, card.board_id, socket)

      _error ->
        nil
    end
  end

  defp update_card_deck("what_can_be_improved", board_id, socket) do
    push(socket, "replace_with", %{
      target: "#what-can-be-improved",
      html:
        render(
          socket,
          ShowComponentView,
          "_what_can_be_improved.html",
          conn: %Plug.Conn{},
          board: Retrospectives.get_board!(board_id)
        )
    })
  end

  defp update_card_deck("what_went_well", board_id, socket) do
    push(socket, "replace_with", %{
      target: "#what-went-well",
      html:
        render(
          socket,
          ShowComponentView,
          "_what_went_well.html",
          conn: %Plug.Conn{},
          board: Retrospectives.get_board!(board_id)
        )
    })
  end
end
