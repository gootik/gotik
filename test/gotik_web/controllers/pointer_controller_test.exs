defmodule GotikWeb.PointerControllerTest do
  use GotikWeb.ConnCase

  import Gotik.PointersFixtures

  @create_attrs %{destination: "some destination", name: "some name"}
  @update_attrs %{destination: "some updated destination", name: "some updated name"}
  @invalid_attrs %{destination: nil, name: nil}

  describe "index" do
    test "lists all pointers", %{conn: conn} do
      conn = get(conn, Routes.pointer_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pointers"
    end
  end

  describe "new pointer" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pointer_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pointer"
    end
  end

  describe "create pointer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pointer_path(conn, :create), pointer: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pointer_path(conn, :show, id)

      conn = get(conn, Routes.pointer_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pointer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pointer_path(conn, :create), pointer: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pointer"
    end
  end

  describe "edit pointer" do
    setup [:create_pointer]

    test "renders form for editing chosen pointer", %{conn: conn, pointer: pointer} do
      conn = get(conn, Routes.pointer_path(conn, :edit, pointer))
      assert html_response(conn, 200) =~ "Edit Pointer"
    end
  end

  describe "update pointer" do
    setup [:create_pointer]

    test "redirects when data is valid", %{conn: conn, pointer: pointer} do
      conn = put(conn, Routes.pointer_path(conn, :update, pointer), pointer: @update_attrs)
      assert redirected_to(conn) == Routes.pointer_path(conn, :show, pointer)

      conn = get(conn, Routes.pointer_path(conn, :show, pointer))
      assert html_response(conn, 200) =~ "some updated destination"
    end

    test "renders errors when data is invalid", %{conn: conn, pointer: pointer} do
      conn = put(conn, Routes.pointer_path(conn, :update, pointer), pointer: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pointer"
    end
  end

  describe "delete pointer" do
    setup [:create_pointer]

    test "deletes chosen pointer", %{conn: conn, pointer: pointer} do
      conn = delete(conn, Routes.pointer_path(conn, :delete, pointer))
      assert redirected_to(conn) == Routes.pointer_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pointer_path(conn, :show, pointer))
      end
    end
  end

  defp create_pointer(_) do
    pointer = pointer_fixture()
    %{pointer: pointer}
  end
end
