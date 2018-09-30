defmodule Retrospectivex.Accounts.Managers.User do
  import Ecto.Query, warn: false

  alias Retrospectivex.Accounts.Schemas.User
  alias Retrospectivex.Repo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the user does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload([:boards, :teams])
  end

  @doc """
  Gets a single user by external_id.

  Raises `Ecto.NoResultsError` if the user does not exist.

  ## Examples

      iex> get_user_by_external_id("external_id")
      %User{}

      iex> get_user_by_external_id("external_id")
      ** (Ecto.NoResultsError)

  """
  def get_user_by_external_id(external_id) do
    Repo.get_by(User, external_id: external_id)
  end

  @doc """
  Gets a single user by external_id.

  Creates a user if the user does not exist.

  ## Examples

      iex> get_or_create_user_by_external_id("external_id", :google)
      %User{}

  """
  def get_or_create_user_by_external_id(external_id, source) do
    external_id = to_string(external_id)

    case get_user_by_external_id(external_id) do
      nil ->
        {:ok, user} = create_user(%{external_id: external_id, source: source})

        user

      user ->
        user
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(User, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(User, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(User)
      {:ok, %User{}}

      iex> delete_user(User)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(User)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
