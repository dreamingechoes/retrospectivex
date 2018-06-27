defmodule RetrospectivexWeb.Admin.PageView do
  use RetrospectivexWeb, :view

  def options_for_status() do
    PageStatusEnum.__enum_map__()
    |> Keyword.keys()
    |> Enum.sort()
  end
end
