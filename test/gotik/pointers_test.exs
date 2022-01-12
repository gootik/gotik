defmodule Gotik.PointersTest do
  use Gotik.DataCase

  alias Gotik.Pointers

  describe "pointers" do
    alias Gotik.Pointers.Pointer

    import Gotik.PointersFixtures

    @invalid_attrs %{destination: nil, name: nil}

    test "list_pointers/0 returns all pointers" do
      pointer = pointer_fixture()
      assert Pointers.list_pointers() == [pointer]
    end

    test "get_pointer!/1 returns the pointer with given id" do
      pointer = pointer_fixture()
      assert Pointers.get_pointer!(pointer.id) == pointer
    end

    test "create_pointer/1 with valid data creates a pointer" do
      valid_attrs = %{destination: "some destination", name: "some name"}

      assert {:ok, %Pointer{} = pointer} = Pointers.create_pointer(valid_attrs)
      assert pointer.destination == "some destination"
      assert pointer.name == "some name"
    end

    test "create_pointer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pointers.create_pointer(@invalid_attrs)
    end

    test "update_pointer/2 with valid data updates the pointer" do
      pointer = pointer_fixture()
      update_attrs = %{destination: "some updated destination", name: "some updated name"}

      assert {:ok, %Pointer{} = pointer} = Pointers.update_pointer(pointer, update_attrs)
      assert pointer.destination == "some updated destination"
      assert pointer.name == "some updated name"
    end

    test "update_pointer/2 with invalid data returns error changeset" do
      pointer = pointer_fixture()
      assert {:error, %Ecto.Changeset{}} = Pointers.update_pointer(pointer, @invalid_attrs)
      assert pointer == Pointers.get_pointer!(pointer.id)
    end

    test "delete_pointer/1 deletes the pointer" do
      pointer = pointer_fixture()
      assert {:ok, %Pointer{}} = Pointers.delete_pointer(pointer)
      assert_raise Ecto.NoResultsError, fn -> Pointers.get_pointer!(pointer.id) end
    end

    test "change_pointer/1 returns a pointer changeset" do
      pointer = pointer_fixture()
      assert %Ecto.Changeset{} = Pointers.change_pointer(pointer)
    end
  end
end
