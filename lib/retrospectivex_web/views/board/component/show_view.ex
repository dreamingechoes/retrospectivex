defmodule RetrospectivexWeb.Board.Component.ShowView do
  use RetrospectivexWeb, :view

  def what_can_be_improved(cards) do
    Enum.filter(cards, &(&1.kind == :what_can_be_improved))
  end

  def what_went_well(cards) do
    Enum.filter(cards, &(&1.kind == :what_went_well))
  end
end
