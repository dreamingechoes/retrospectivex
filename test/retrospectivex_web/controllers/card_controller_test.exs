defmodule RetrospectivexWeb.CardControllerTest do
  use RetrospectivexWeb.ConnCase

  alias Retrospectivex.Retrospectives

  @create_attrs %{body: "some body", title: "some title", votes: 42}
  @update_attrs %{
    body: "some updated body",
    title: "some updated title",
    votes: 43
  }
  @invalid_attrs %{body: nil, title: nil, votes: nil}

  def fixture(:card) do
    {:ok, card} = Retrospectives.create_card(@create_attrs)
    card
  end

  describe "index" do
    test "lists all cards", %{conn: conn} do
      conn = get(conn, card_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Cards"
    end
  end

  describe "new card" do
    test "renders form", %{conn: conn} do
      conn = get(conn, card_path(conn, :new))
      assert html_response(conn, 200) =~ "New Card"
    end
  end

  describe "create card" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, card_path(conn, :create), card: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == card_path(conn, :show, id)

      conn = get(conn, card_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Card"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, card_path(conn, :create), card: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Card"
    end
  end

  describe "edit card" do
    setup [:create_card]

    test "renders form for editing chosen card", %{conn: conn, card: card} do
      conn = get(conn, card_path(conn, :edit, card))
      assert html_response(conn, 200) =~ "Edit Card"
    end
  end

  describe "update card" do
    setup [:create_card]

    test "redirects when data is valid", %{conn: conn, card: card} do
      conn = put(conn, card_path(conn, :update, card), card: @update_attrs)
      assert redirected_to(conn) == card_path(conn, :show, card)

      conn = get(conn, card_path(conn, :show, card))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, card: card} do
      conn = put(conn, card_path(conn, :update, card), card: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Card"
    end
  end

  describe "delete card" do
    setup [:create_card]

    test "deletes chosen card", %{conn: conn, card: card} do
      conn = delete(conn, card_path(conn, :delete, card))
      assert redirected_to(conn) == card_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, card_path(conn, :show, card))
      end)
    end
  end

  defp create_card(_) do
    card = fixture(:card)
    {:ok, card: card}
  end
end
