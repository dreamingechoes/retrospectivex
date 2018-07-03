defmodule Retrospectivex.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Retrospectivex.Accounts.Managers.Administrator, as: AdministratorManager

  # Administrator API
  defdelegate change_administrator(administrator), to: AdministratorManager
  defdelegate create_administrator(attrs), to: AdministratorManager
  defdelegate delete_administrator(administrator), to: AdministratorManager
  defdelegate get_administrator_by_email!(email), to: AdministratorManager
  defdelegate get_administrator!(id), to: AdministratorManager
  defdelegate list_administrators, to: AdministratorManager

  defdelegate update_administrator(administrator, attrs),
    to: AdministratorManager
end
