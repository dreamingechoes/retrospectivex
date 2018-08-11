defmodule Retrospectivex.Retrospectives.Managers.Board do
  import Ecto.Query, warn: false

  alias Retrospectivex.Repo
  alias Retrospectivex.Retrospectives.Schemas.Board

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """
  def list_boards do
    Repo.all(Board)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id) do
    Board
    |> Repo.get!(id)
    |> Repo.preload([:cards])
  end

  @doc """
  Gets a single board by slug and uuid.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board_by_slug_and_uuid!("some-slug", "some-uuid")
      %Board{}

      iex> get_board_by_slug_and_uuid!("some-slug", "some-uuid")
      ** (Ecto.NoResultsError)

  """
  def get_board_by_slug_and_uuid!(slug, uuid) do
    Board
    |> Repo.get_by!(slug: slug, uuid: uuid)
    |> Repo.preload([:cards])
  end

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{source: %Board{}}

  """
  def change_board(%Board{} = board) do
    Board.changeset(board, %{})
  end
end
