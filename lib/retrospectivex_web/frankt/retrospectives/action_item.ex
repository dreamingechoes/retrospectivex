defmodule RetrospectivexWeb.Frankt.Retrospectives.ActionItem do
  use RetrospectivexWeb, :frankt

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.ActionItem
  alias RetrospectivexWeb.ActionItemView

  def create_modal(%{"card_id" => card_id}, socket) do
    html =
      render(
        socket,
        ActionItemView,
        "form.html",
        changeset:
          Retrospectives.change_action_item(%ActionItem{card_id: card_id})
      )

    push(socket, "open_modal", %{html: html})
    push(socket, "activate_codemirror", %{id: "action_item_params_body"})
  end

  def create(%{"action_item_params" => action_item_params}, socket) do
    push(socket, "close_modal", %{})

    case Retrospectives.create_action_item(action_item_params) do
      {:ok, action_item} ->
        update_stack(action_item.card_id, %{}, socket)

      _error ->
        nil
    end
  end

  def show_modal(%{"action_item_id" => action_item_id}, socket) do
    action_item = Retrospectives.get_action_item!(action_item_id)

    html = render(socket, ActionItemView, "show.html", action_item: action_item)

    push(socket, "open_modal", %{html: html})
  end

  def edit_modal(%{"action_item_id" => action_item_id}, socket) do
    action_item = Retrospectives.get_action_item!(action_item_id)

    html =
      render(
        socket,
        ActionItemView,
        "form.html",
        changeset: Retrospectives.change_action_item(action_item)
      )

    push(socket, "update_modal", %{html: html})
    push(socket, "activate_codemirror", %{id: "action_item_params_body"})
  end

  def update(
        %{
          "action_item_params" =>
            action_item_params = %{"id" => action_item_id},
          "action_item_filters" => action_item_filters
        },
        socket
      ) do
    action_item = Retrospectives.get_action_item!(action_item_id)

    case Retrospectives.update_action_item(action_item, action_item_params) do
      {:ok, action_item} ->
        update_stack(action_item.card_id, action_item_filters, socket)

        html =
          render(socket, ActionItemView, "show.html", action_item: action_item)

        push(socket, "update_modal", %{html: html})

      _error ->
        nil
    end
  end

  def delete_modal(%{"action_item_id" => action_item_id}, socket) do
    html =
      render(
        socket,
        ActionItemView,
        "_delete_modal.html",
        action_item_id: action_item_id
      )

    push(socket, "open_modal", %{html: html})
  end

  def delete(
        %{
          "action_item_id" => action_item_id
        },
        socket
      ) do
    action_item = Retrospectives.get_action_item!(action_item_id)

    case Retrospectives.delete_action_item(action_item) do
      {:ok, action_item} ->
        update_stack(action_item.card_id, %{}, socket)
        push(socket, "close_modal", %{})

      _error ->
        nil
    end
  end

  defp update_stack(board_id, action_item_filters, socket) do
    push(socket, "replace_with", %{
      target: "#action-items",
      html:
        render(
          socket,
          ActionItemView,
          "_action_items.html",
          conn: %Plug.Conn{},
          board: Retrospectives.get_board!(board_id, action_item_filters)
        )
    })

    push(socket, "setup_accordion", %{})
  end
end
