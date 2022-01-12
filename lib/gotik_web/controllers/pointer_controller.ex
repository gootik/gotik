defmodule GotikWeb.PointerController do
  use GotikWeb, :controller

  alias Gotik.Pointers
  alias Gotik.Pointers.Pointer

  def index(conn, _params) do
    pointers = Pointers.list_pointers()
    render(conn, "index.html", pointers: pointers)
  end

  def new(conn, _params) do
    changeset = Pointers.change_pointer(%Pointer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pointer" => pointer_params}) do
    case Pointers.create_pointer(pointer_params) do
      {:ok, pointer} ->
        conn
        |> put_flash(:info, "Pointer created successfully.")
        |> redirect(to: Routes.pointer_path(conn, :show, pointer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pointer = Pointers.get_pointer!(id)
    render(conn, "show.html", pointer: pointer)
  end

  def edit(conn, %{"id" => id}) do
    pointer = Pointers.get_pointer!(id)
    changeset = Pointers.change_pointer(pointer)
    render(conn, "edit.html", pointer: pointer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pointer" => pointer_params}) do
    pointer = Pointers.get_pointer!(id)

    case Pointers.update_pointer(pointer, pointer_params) do
      {:ok, pointer} ->
        conn
        |> put_flash(:info, "Pointer updated successfully.")
        |> redirect(to: Routes.pointer_path(conn, :show, pointer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pointer: pointer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pointer = Pointers.get_pointer!(id)
    {:ok, _pointer} = Pointers.delete_pointer(pointer)

    conn
    |> put_flash(:info, "Pointer deleted successfully.")
    |> redirect(to: Routes.pointer_path(conn, :index))
  end

  def direct(conn, %{"pointer" => pointer_name}) do
    case Gotik.Pointers.get_pointer_by_name(pointer_name) do
      nil ->
        conn
        |> put_flash(:error, pointer_name <> " not found")
        |> redirect(to: Routes.pointer_path(conn, :index))
      pointer ->
        conn
        |> redirect(external: pointer.destination)
    end
  end
end
