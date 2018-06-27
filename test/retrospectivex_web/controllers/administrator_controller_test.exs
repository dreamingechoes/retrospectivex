defmodule RetrospectivexWeb.AdministratorControllerTest do
  use RetrospectivexWeb.ConnCase

  alias Retrospectivex.Accounts

  @create_attrs %{
    email: "some email",
    encrypted_password: "some encrypted_password",
    first_name: "some first_name",
    last_name: "some last_name"
  }
  @update_attrs %{
    email: "some updated email",
    encrypted_password: "some updated encrypted_password",
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{
    email: nil,
    encrypted_password: nil,
    first_name: nil,
    last_name: nil
  }

  def fixture(:administrator) do
    {:ok, administrator} = Accounts.create_administrator(@create_attrs)
    administrator
  end

  describe "index" do
    test "lists all administrators", %{conn: conn} do
      conn = get(conn, administrator_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Administrators"
    end
  end

  describe "new administrator" do
    test "renders form", %{conn: conn} do
      conn = get(conn, administrator_path(conn, :new))
      assert html_response(conn, 200) =~ "New Administrator"
    end
  end

  describe "create administrator" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(
          conn,
          administrator_path(conn, :create),
          administrator: @create_attrs
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == administrator_path(conn, :show, id)

      conn = get(conn, administrator_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Administrator"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(
          conn,
          administrator_path(conn, :create),
          administrator: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "New Administrator"
    end
  end

  describe "edit administrator" do
    setup [:create_administrator]

    test "renders form for editing chosen administrator", %{
      conn: conn,
      administrator: administrator
    } do
      conn = get(conn, administrator_path(conn, :edit, administrator))
      assert html_response(conn, 200) =~ "Edit Administrator"
    end
  end

  describe "update administrator" do
    setup [:create_administrator]

    test "redirects when data is valid", %{
      conn: conn,
      administrator: administrator
    } do
      conn =
        put(
          conn,
          administrator_path(conn, :update, administrator),
          administrator: @update_attrs
        )

      assert redirected_to(conn) ==
               administrator_path(conn, :show, administrator)

      conn = get(conn, administrator_path(conn, :show, administrator))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      administrator: administrator
    } do
      conn =
        put(
          conn,
          administrator_path(conn, :update, administrator),
          administrator: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Administrator"
    end
  end

  describe "delete administrator" do
    setup [:create_administrator]

    test "deletes chosen administrator", %{
      conn: conn,
      administrator: administrator
    } do
      conn = delete(conn, administrator_path(conn, :delete, administrator))
      assert redirected_to(conn) == administrator_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, administrator_path(conn, :show, administrator))
      end)
    end
  end

  defp create_administrator(_) do
    administrator = fixture(:administrator)
    {:ok, administrator: administrator}
  end
end
