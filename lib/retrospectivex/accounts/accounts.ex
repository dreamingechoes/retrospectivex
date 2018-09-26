defmodule Retrospectivex.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Retrospectivex.Accounts.Managers.Administrator, as: AdministratorManager
  alias Retrospectivex.Accounts.Managers.User, as: UserManager

  # Administrator API
  defdelegate change_administrator(administrator), to: AdministratorManager
  defdelegate create_administrator(attrs), to: AdministratorManager
  defdelegate delete_administrator(administrator), to: AdministratorManager
  defdelegate get_administrator_by_email!(email), to: AdministratorManager
  defdelegate get_administrator!(id), to: AdministratorManager
  defdelegate list_administrators, to: AdministratorManager

  defdelegate update_administrator(administrator, attrs),
    to: AdministratorManager

  # User API
  defdelegate change_user(user), to: UserManager
  defdelegate create_user(attrs), to: UserManager
  defdelegate delete_user(user), to: UserManager

  defdelegate get_or_create_user_by_external_id(external_id, source),
    to: UserManager

  defdelegate get_user_by_external_id(external_id), to: UserManager
  defdelegate get_user!(id), to: UserManager
  defdelegate list_users, to: UserManager
  defdelegate update_user(user, attrs), to: UserManager
end
