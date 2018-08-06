defmodule RetrospectivexWeb.BoardView do
  use RetrospectivexWeb, :view

  def options_for_status do
    BoardStatusEnum.__enum_map__()
    |> Keyword.keys()
    |> Enum.sort()
  end
end
