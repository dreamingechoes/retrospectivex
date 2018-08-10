defmodule RetrospectivexWeb.Frankt.Retrospectives.Board do
  use RetrospectivexWeb, :frankt

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Card
  alias RetrospectivexWeb.CardView

  def create_card_modal(%{"board_id" => board_id}, socket) do
    html =
      render(
        socket,
        CardView,
        "form.html",
        changeset: Retrospectives.change_card(%Card{board_id: board_id})
      )

    push(socket, "open_modal", %{html: html})
  end

  def create_card(%{"card_params" => card_params}, socket) do
    push(socket, "close_modal", %{})

    case Retrospectives.create_card(card_params) do
      {:ok, card} -> nil # push_flash(socket, :info, "")
      _error -> nil # push_flash(socket, :error, "")
    end
  end
end
