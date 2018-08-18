defmodule RetrospectivexWeb.Frankt.Retrospectives.Board do
  use RetrospectivexWeb, :frankt

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Card
  alias RetrospectivexWeb.Board.Component.ShowView, as: ShowComponentView
  alias RetrospectivexWeb.CardView

  def filter_cards(%{"board_filters" => board_filters}, socket) do
  end
end
