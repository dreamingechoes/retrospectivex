defmodule RetrospectivexWeb.BoardView do
  use RetrospectivexWeb, :view

  alias RetrospectivexWeb.Board.Component.ShowView, as: ShowComponentView

  def options_for_status do
    BoardStatusEnum.__enum_map__()
    |> Keyword.keys()
    |> Enum.sort()
  end
end
