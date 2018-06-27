defmodule RetrospectivexWeb.PageControllerTest do
  use RetrospectivexWeb.ConnCase

  alias Retrospectivex.Contents

  @create_attrs %{
    description: "some description",
    seo_infos: [],
    slug: "some slug",
    status: 42,
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    seo_infos: [],
    slug: "some updated slug",
    status: 43,
    title: "some updated title"
  }
  @invalid_attrs %{
    description: nil,
    seo_infos: nil,
    slug: nil,
    status: nil,
    title: nil
  }

  def fixture(:page) do
    {:ok, page} = Contents.create_page(@create_attrs)
    page
  end

  describe "index" do
    test "lists all pages", %{conn: conn} do
      conn = get(conn, page_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pages"
    end
  end

  describe "new page" do
    test "renders form", %{conn: conn} do
      conn = get(conn, page_path(conn, :new))
      assert html_response(conn, 200) =~ "New Page"
    end
  end

  describe "create page" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, page_path(conn, :create), page: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == page_path(conn, :show, id)

      conn = get(conn, page_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Page"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, page_path(conn, :create), page: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Page"
    end
  end

  describe "edit page" do
    setup [:create_page]

    test "renders form for editing chosen page", %{conn: conn, page: page} do
      conn = get(conn, page_path(conn, :edit, page))
      assert html_response(conn, 200) =~ "Edit Page"
    end
  end

  describe "update page" do
    setup [:create_page]

    test "redirects when data is valid", %{conn: conn, page: page} do
      conn = put(conn, page_path(conn, :update, page), page: @update_attrs)
      assert redirected_to(conn) == page_path(conn, :show, page)

      conn = get(conn, page_path(conn, :show, page))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, page: page} do
      conn = put(conn, page_path(conn, :update, page), page: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Page"
    end
  end

  describe "delete page" do
    setup [:create_page]

    test "deletes chosen page", %{conn: conn, page: page} do
      conn = delete(conn, page_path(conn, :delete, page))
      assert redirected_to(conn) == page_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, page_path(conn, :show, page))
      end)
    end
  end

  defp create_page(_) do
    page = fixture(:page)
    {:ok, page: page}
  end
end
