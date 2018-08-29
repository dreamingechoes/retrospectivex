defmodule Retrospectivex.RetrospectivesTest do
  use Retrospectivex.DataCase

  alias Retrospectivex.Retrospectives

  describe "boards" do
    alias Retrospectivex.Retrospectives.Schemas.Board

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

  describe "cards" do
    alias Retrospectivex.Retrospectives.Card

    @valid_attrs %{body: "some body", title: "some title", votes: 42}
    @update_attrs %{
      body: "some updated body",
      title: "some updated title",
      votes: 43
    }
    @invalid_attrs %{body: nil, title: nil, votes: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Retrospectives.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Retrospectives.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Retrospectives.create_card(@valid_attrs)
      assert card.body == "some body"
      assert card.title == "some title"
      assert card.votes == 42
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, card} = Retrospectives.update_card(card, @update_attrs)
      assert %Card{} = card
      assert card.body == "some updated body"
      assert card.title == "some updated title"
      assert card.votes == 43
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_card(card, @invalid_attrs)

      assert card == Retrospectives.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Retrospectives.delete_card(card)

      assert_raise Ecto.NoResultsError, fn ->
        Retrospectives.get_card!(card.id)
      end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_card(card)
    end
  end

  describe "action_items" do
    alias Retrospectivex.Retrospectives.ActionItem

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def action_item_fixture(attrs \\ %{}) do
      {:ok, action_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_action_item()

      action_item
    end

    test "list_action_items/0 returns all action_items" do
      action_item = action_item_fixture()
      assert Retrospectives.list_action_items() == [action_item]
    end

    test "get_action_item!/1 returns the action_item with given id" do
      action_item = action_item_fixture()
      assert Retrospectives.get_action_item!(action_item.id) == action_item
    end

    test "create_action_item/1 with valid data creates a action_item" do
      assert {:ok, %ActionItem{} = action_item} =
               Retrospectives.create_action_item(@valid_attrs)

      assert action_item.body == "some body"
      assert action_item.title == "some title"
    end

    test "create_action_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.create_action_item(@invalid_attrs)
    end

    test "update_action_item/2 with valid data updates the action_item" do
      action_item = action_item_fixture()

      assert {:ok, action_item} =
               Retrospectives.update_action_item(action_item, @update_attrs)

      assert %ActionItem{} = action_item
      assert action_item.body == "some updated body"
      assert action_item.title == "some updated title"
    end

    test "update_action_item/2 with invalid data returns error changeset" do
      action_item = action_item_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_action_item(action_item, @invalid_attrs)

      assert action_item == Retrospectives.get_action_item!(action_item.id)
    end

    test "delete_action_item/1 deletes the action_item" do
      action_item = action_item_fixture()

      assert {:ok, %ActionItem{}} =
               Retrospectives.delete_action_item(action_item)

      assert_raise Ecto.NoResultsError, fn ->
        Retrospectives.get_action_item!(action_item.id)
      end
    end

    test "change_action_item/1 returns a action_item changeset" do
      action_item = action_item_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_action_item(action_item)
    end
  end
end
