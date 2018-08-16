defmodule RetrospectivexWeb.Frankt.Retrospectives.Board do
  use RetrospectivexWeb, :frankt

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Card
  alias RetrospectivexWeb.Board.Component.ShowView, as: ShowComponentView
  alias RetrospectivexWeb.CardView

  def filter_cards(%{"board_filters" => board_filters}, socket) do
  end

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
    push(socket, "activate_codemirror", %{id: "card_params_body"})
  end

  def create_card(%{"card_params" => card_params = %{"kind" => kind}}, socket) do
    push(socket, "close_modal", %{})

    case Retrospectives.create_card(card_params) do
      {:ok, card} ->
        update_card_stack(kind, card.board_id, socket)

      _error ->
        nil
    end
  end

  def vote_card(%{"card_id" => card_id, "kind" => kind}, socket) do
    card = Retrospectives.get_card!(card_id)

    case Retrospectives.update_card(card, %{votes: upvote_card(card)}) do
      {:ok, card} ->
        update_card_stack(kind, card.board_id, socket)

      _error ->
        nil
    end
  end

  def show_card_modal(%{"card_id" => card_id, "kind" => kind}, socket) do
    card = Retrospectives.get_card!(card_id)

    html = render(socket, CardView, "show.html", card: card, kind: kind)

    push(socket, "open_modal", %{html: html})
  end

  def edit_card_modal(%{"card_id" => card_id, "kind" => kind}, socket) do
    card = Retrospectives.get_card!(card_id)

    html =
      render(
        socket,
        CardView,
        "form.html",
        changeset: Retrospectives.change_card(card)
      )

    push(socket, "update_modal", %{html: html})
    push(socket, "activate_codemirror", %{id: "card_params_body"})
  end

  def update_card(
        %{"card_params" => card_params = %{"id" => card_id, "kind" => kind}},
        socket
      ) do
    card = Retrospectives.get_card!(card_id)

    push(socket, "close_modal", %{})

    case Retrospectives.update_card(card, card_params) do
      {:ok, card} ->
        update_card_stack(kind, card.board_id, socket)

      _error ->
        nil
    end
  end

  def delete_card_modal(%{"card_id" => card_id, "kind" => kind}, socket) do
    html =
      render(
        socket,
        CardView,
        "_delete_modal.html",
        card_id: card_id,
        kind: kind
      )

    push(socket, "open_modal", %{html: html})
  end

  def delete_card(%{"card_id" => card_id, "kind" => kind}, socket) do
    card = Retrospectives.get_card!(card_id)

    case Retrospectives.delete_card(card) do
      {:ok, card} ->
        update_card_stack(kind, card.board_id, socket)
        push(socket, "close_modal", %{})

      _error ->
        nil
    end
  end

  defp update_card_stack(kind, board_id, socket) do
    push(socket, "replace_with", %{
      target: "##{kind}",
      html:
        render(
          socket,
          ShowComponentView,
          "_cards.html",
          conn: %Plug.Conn{},
          board: Retrospectives.get_board!(board_id),
          kind: String.to_atom(kind)
        )
    })

    push(socket, "setup_accordion", %{})
  end

  defp upvote_card(%{votes: nil}), do: 1
  defp upvote_card(%{votes: votes}), do: votes + 1
end
