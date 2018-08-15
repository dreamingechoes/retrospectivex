defmodule RetrospectivexWeb.CardView do
  use RetrospectivexWeb, :view

  def card_form_action(%{data: %{id: nil}}), do: "board:create_card"
  def card_form_action(%{data: %{id: _}}), do: "board:update_card"

  def title_card_form(%{data: %{id: nil}}), do: gettext("Add New Card")
  def title_card_form(%{data: %{id: _}}), do: gettext("Edit Card")
end
