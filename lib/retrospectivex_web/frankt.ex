defmodule RetrospectivexWeb.Frankt do
  import Phoenix.Channel

  alias Phoenix.View
  alias RetrospectivexWeb.LayoutView

  def push_flash(socket, :error, message) do
    html =
      View.render_to_string(
        LayoutView,
        "_flash_messages.html",
        message: message
      )

    do_push_flash(socket, html)
  end

  def push_flash(socket, :info, message) do
    html =
      View.render_to_string(
        LayoutView,
        "_flash_messages.html",
        message: message
      )

    do_push_flash(socket, html)
  end

  def render(socket, view, template, assigns \\ []) when is_list(assigns) do
    View.render_to_string(view, template, Enum.into(socket.assigns, assigns))
  end

  defp do_push_flash(socket, html) do
    push(socket, "prepend", %{target: "#flash-container", html: html})
  end
end
