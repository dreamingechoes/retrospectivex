defmodule RetrospectivexWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel("frankt", RetrospectivexWeb.FranktChannel)

  ## Transports
  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket), do: {:ok, socket}

  def id(_socket), do: nil
end
