defmodule RetrospectivexWeb.Frankt.Global do
  use RetrospectivexWeb, :frankt

  def close_modal(_params, socket) do
    push(socket, "close_modal", %{})
  end
end
