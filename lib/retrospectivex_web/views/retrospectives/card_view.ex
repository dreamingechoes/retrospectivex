defmodule RetrospectivexWeb.Retrospectives.CardView do
  use RetrospectivexWeb, :view

  def card_form_action(%{data: %{id: nil}}), do: "card:create"
  def card_form_action(%{data: %{id: _}}), do: "card:update"

  def title_card_form(%{data: %{id: nil}}), do: gettext("Add New Card")
  def title_card_form(%{data: %{id: _}}), do: gettext("Edit Card")
end
