defmodule RetrospectivexWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel("frankt", RetrospectivexWeb.FranktChannel)

  def connect(_params, socket), do: {:ok, socket}

  def id(_socket), do: nil
end
