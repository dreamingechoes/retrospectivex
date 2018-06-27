defmodule Retrospectivex.ContentsTest do
  use Retrospectivex.DataCase

  alias Retrospectivex.Contents

  describe "pages" do
    alias Retrospectivex.Contents.Page

    @valid_attrs %{
      body: "some body",
      seo_infos: [],
      slug: "some slug",
      status: 42,
      title: "some title"
    }
    @update_attrs %{
      body: "some updated body",
      seo_infos: [],
      slug: "some updated slug",
      status: 43,
      title: "some updated title"
    }
    @invalid_attrs %{
      body: nil,
      seo_infos: nil,
      slug: nil,
      status: nil,
      title: nil
    }

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contents.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Contents.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Contents.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Contents.create_page(@valid_attrs)
      assert page.body == "some body"
      assert page.seo_infos == []
      assert page.slug == "some slug"
      assert page.status == 42
      assert page.title == "some title"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contents.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = Contents.update_page(page, @update_attrs)
      assert %Page{} = page
      assert page.body == "some updated body"
      assert page.seo_infos == []
      assert page.slug == "some updated slug"
      assert page.status == 43
      assert page.title == "some updated title"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Contents.update_page(page, @invalid_attrs)

      assert page == Contents.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Contents.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Contents.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Contents.change_page(page)
    end
  end
end
