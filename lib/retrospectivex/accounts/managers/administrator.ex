defmodule Retrospectivex.Accounts.Managers.Administrator do
  import Ecto.Query, warn: false

  alias Retrospectivex.Accounts.Queries.Administrator, as: Query
  alias Retrospectivex.Accounts.Schemas.Administrator
  alias Retrospectivex.Repo

  @doc """
  Returns the list of administrators.

  ## Examples

      iex> list_administrators()
      [%Administrator{}, ...]

  """
  def list_administrators do
    Repo.all(Administrator)
  end

  @doc """
  Gets a single administrator.

  Raises `Ecto.NoResultsError` if the Administrator does not exist.

  ## Examples

      iex> get_administrator!(123)
      %Administrator{}

      iex> get_administrator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_administrator!(id), do: Repo.get!(Administrator, id)

  @doc """
  Gets a single administrator by email.

  Raises `Ecto.NoResultsError` if the Administrator does not exist.

  ## Examples

      iex> get_administrator_by_email!("some@email.com")
      %Administrator{}

      iex> get_administrator_by_email!("some@email.com")
      ** (Ecto.NoResultsError)

  """
  def get_administrator_by_email!(email) do
    email
    |> Query.by_email()
    |> Repo.one!()
  end

  @doc """
  Creates a administrator.

  ## Examples

      iex> create_administrator(%{field: value})
      {:ok, %Administrator{}}

      iex> create_administrator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_administrator(attrs \\ %{}) do
    %Administrator{}
    |> Administrator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a administrator.

  ## Examples

      iex> update_administrator(administrator, %{field: new_value})
      {:ok, %Administrator{}}

      iex> update_administrator(administrator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_administrator(%Administrator{} = administrator, attrs) do
    administrator
    |> Administrator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Administrator.

  ## Examples

      iex> delete_administrator(administrator)
      {:ok, %Administrator{}}

      iex> delete_administrator(administrator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_administrator(%Administrator{} = administrator) do
    Repo.delete(administrator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking administrator changes.

  ## Examples

      iex> change_administrator(administrator)
      %Ecto.Changeset{source: %Administrator{}}

  """
  def change_administrator(%Administrator{} = administrator) do
    Administrator.changeset(administrator, %{})
  end
end
