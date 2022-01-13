defmodule GotikWeb.PointerController do
  use GotikWeb, :controller

  alias Gotik.Pointers
  alias Gotik.Pointers.Pointer

  import GotikWeb.UserAuth

  plug :require_authenticated_user when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    pointers = Pointers.list_pointers()
    render(conn, "index.html", pointers: pointers)
  end

  def new(conn, _params) do
    changeset = Pointers.change_pointer(%Pointer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pointer" => pointer_params}) do
    user = conn.assigns.current_user
    pointer_params = Map.put(pointer_params, "user_id", user.id)

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
    user = conn.assigns.current_user

    if pointer.user_id != user.id do
      conn
      |> put_flash(:info, "You cannot change other user's pointer")
      |> redirect(to: Routes.pointer_path(conn, :index))
    else
      changeset = Pointers.change_pointer(pointer)
      render(conn, "edit.html", pointer: pointer, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "pointer" => pointer_params}) do
    pointer = Pointers.get_pointer!(id)
    user = conn.assigns.current_user

    if pointer.user_id != user.id do
      conn
      |> put_flash(:info, "You cannot change other user's pointer")
      |> redirect(to: Routes.pointer_path(conn, :index))
    else
      case Pointers.update_pointer(pointer, pointer_params) do
        {:ok, pointer} ->
          conn
          |> put_flash(:info, "Pointer updated successfully.")
          |> redirect(to: Routes.pointer_path(conn, :show, pointer))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", pointer: pointer, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    pointer = Pointers.get_pointer!(id)
    user = conn.assigns.current_user

    if pointer.user_id != user.id do
      conn
      |> put_flash(:info, "You cannot change other user's pointer")
      |> redirect(to: Routes.pointer_path(conn, :index))
    else
      {:ok, _pointer} = Pointers.delete_pointer(pointer)

      conn
      |> put_flash(:info, "Pointer deleted successfully.")
      |> redirect(to: Routes.pointer_path(conn, :index))
    end
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
