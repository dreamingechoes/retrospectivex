defmodule RetrospectivexWeb.BoardView do
  use RetrospectivexWeb, :view

  alias RetrospectivexWeb.Board.Component.ShowView, as: ShowComponentView

  def format_date(nil), do: gettext("No date specified")
  def format_date(date), do: Enum.join([date.year, date.month, date.day], "/")
end
