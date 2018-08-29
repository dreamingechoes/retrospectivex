defmodule RetrospectivexWeb.Admin.BoardView do
  use RetrospectivexWeb, :view

  def options_for_state do
    BoardStateEnum.__enum_map__()
    |> Keyword.keys()
    |> Enum.sort()
  end
end
