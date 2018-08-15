defmodule RetrospectivexWeb.CardView do
  use RetrospectivexWeb, :view

  def title_card_form(%{data: %{id: nil}}), do: gettext("Add New Card")
  def title_card_form(%{data: %{id: _}}), do: gettext("Edit Card")
end
