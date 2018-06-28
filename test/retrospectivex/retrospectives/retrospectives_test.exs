defmodule Retrospectivex.RetrospectivesTest do
  use Retrospectivex.DataCase

  alias Retrospectivex.Retrospectives

  describe "boards" do
    alias Retrospectivex.Retrospectives.Board

    @valid_attrs %{
      description: "some description",
      slug: "some slug",
      status: 42,
      title: "some title"
    }
    @update_attrs %{
      description: "some updated description",
      slug: "some updated slug",
      status: 43,
      title: "some updated title"
    }
    @invalid_attrs %{description: nil, slug: nil, status: nil, title: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Retrospectives.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Retrospectives.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = Retrospectives.create_board(@valid_attrs)
      assert board.description == "some description"
      assert board.slug == "some slug"
      assert board.status == 42
      assert board.title == "some title"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, board} = Retrospectives.update_board(board, @update_attrs)
      assert %Board{} = board
      assert board.description == "some updated description"
      assert board.slug == "some updated slug"
      assert board.status == 43
      assert board.title == "some updated title"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_board(board, @invalid_attrs)

      assert board == Retrospectives.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Retrospectives.delete_board(board)

      assert_raise Ecto.NoResultsError, fn ->
        Retrospectives.get_board!(board.id)
      end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_board(board)
    end
  end
end
