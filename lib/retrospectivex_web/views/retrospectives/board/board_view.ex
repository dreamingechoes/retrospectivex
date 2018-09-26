defmodule RetrospectivexWeb.Retrospectives.BoardView do
  use RetrospectivexWeb, :view

  alias RetrospectivexWeb.Retrospectives.Board.Component.ShowView,
    as: ShowComponentView

  def format_date(nil), do: gettext("No date specified")

  def format_date(date) do
    minutes =
      date.minute
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    "#{date.year}/#{date.month}/#{date.day} - #{date.hour}:#{minutes}h"
  end
end
