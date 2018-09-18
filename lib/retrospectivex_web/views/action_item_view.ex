defmodule RetrospectivexWeb.ActionItemView do
  use RetrospectivexWeb, :view

  def action_item_form_action(%{data: %{id: nil}}), do: "action_item:create"
  def action_item_form_action(%{data: %{id: _}}), do: "action_item:update"

  def title_action_item_form(%{data: %{id: nil}}),
    do: gettext("Add New Action Item")

  def title_action_item_form(%{data: %{id: _}}), do: gettext("Edit Action Item")
end
