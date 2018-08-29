defmodule Retrospectivex.Retrospectives.Managers.ActionItem do
  import Ecto.Query, warn: false

  alias Retrospectivex.Repo
  alias Retrospectivex.Retrospectives.Schemas.ActionItem

  @doc """
  Returns the list of action_items.

  ## Examples

      iex> list_action_items()
      [%ActionItem{}, ...]

  """
  def list_action_items do
    Repo.all(ActionItem)
  end

  @doc """
  Gets a single action_item.

  Raises `Ecto.NoResultsError` if the Action item does not exist.

  ## Examples

      iex> get_action_item!(123)
      %ActionItem{}

      iex> get_action_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_action_item!(id), do: Repo.get!(ActionItem, id)

  @doc """
  Creates a action_item.

  ## Examples

      iex> create_action_item(%{field: value})
      {:ok, %ActionItem{}}

      iex> create_action_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_action_item(attrs \\ %{}) do
    %ActionItem{}
    |> ActionItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a action_item.

  ## Examples

      iex> update_action_item(action_item, %{field: new_value})
      {:ok, %ActionItem{}}

      iex> update_action_item(action_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_action_item(%ActionItem{} = action_item, attrs) do
    action_item
    |> ActionItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ActionItem.

  ## Examples

      iex> delete_action_item(action_item)
      {:ok, %ActionItem{}}

      iex> delete_action_item(action_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_action_item(%ActionItem{} = action_item) do
    Repo.delete(action_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action_item changes.

  ## Examples

      iex> change_action_item(action_item)
      %Ecto.Changeset{source: %ActionItem{}}

  """
  def change_action_item(%ActionItem{} = action_item) do
    ActionItem.changeset(action_item, %{})
  end
end
