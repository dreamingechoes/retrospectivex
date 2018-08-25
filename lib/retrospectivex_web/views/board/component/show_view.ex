defmodule RetrospectivexWeb.Board.Component.ShowView do
  use RetrospectivexWeb, :view

  import RetrospectivexWeb.BoardView, only: [format_date: 1]

  defp board_order_by_options do
    [
      {gettext("Votes"), "votes"},
      {gettext("Creation date"), "inserted_at"}
    ]
  end

  def get_stack_cards(cards, :what_can_be_improved) do
    Enum.filter(cards, &(&1.kind == :what_can_be_improved))
  end

  def get_stack_cards(cards, :what_went_well) do
    Enum.filter(cards, &(&1.kind == :what_went_well))
  end

  def title_cards_stack(kind) do
    "#{kind}"
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(" ")
  end

  def title_cards_stack_bg_color(:what_can_be_improved), do: "bg-danger"
  def title_cards_stack_bg_color(:what_went_well), do: "bg-success"
end
