defmodule RetrospectivexWeb.FranktChannel do
  use RetrospectivexWeb, :channel
  use Frankt

  def join("frankt", _params, socket), do: {:ok, socket}

  def handlers do
    %{
      "board" => RetrospectivexWeb.Frankt.Retrospectives.Board
    }
  end
end
