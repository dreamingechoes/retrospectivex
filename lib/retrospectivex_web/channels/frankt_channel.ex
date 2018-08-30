defmodule RetrospectivexWeb.FranktChannel do
  use RetrospectivexWeb, :channel
  use Frankt

  def join("frankt", _params, socket), do: {:ok, socket}

  def handlers do
    %{
      # Global module
      "global" => RetrospectivexWeb.Frankt.Global,

      # Retrospectives context modules
      "action_item" => RetrospectivexWeb.Frankt.Retrospectives.ActionItem,
      "card" => RetrospectivexWeb.Frankt.Retrospectives.Card,
      "board" => RetrospectivexWeb.Frankt.Retrospectives.Board
    }
  end
end
