defmodule Retrospectivex.Contents do
  @moduledoc """
  The Contents context.
  """

  alias Retrospectivex.Contents.Managers.Page, as: PageManager

  # Page API
  defdelegate list_pages, to: PageManager
  defdelegate get_page!(id), to: PageManager
  defdelegate get_page_by_slug!(slug), to: PageManager
  defdelegate create_page(attrs), to: PageManager
  defdelegate update_page(page, attrs), to: PageManager
  defdelegate delete_page(page), to: PageManager
  defdelegate change_page(page), to: PageManager
end
