defmodule Gotik.Pointers do
  @moduledoc """
  The Pointers context.
  """

  import Ecto.Query, warn: false
  alias Gotik.Repo

  alias Gotik.Pointers.Pointer

  @doc """
  Returns the list of pointers.

  ## Examples

      iex> list_pointers()
      [%Pointer{}, ...]

  """
  def list_pointers do
    Pointer
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single pointer.

  Raises `Ecto.NoResultsError` if the Pointer does not exist.

  ## Examples

      iex> get_pointer!(123)
      %Pointer{}

      iex> get_pointer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pointer!(id), do: Repo.get!(Pointer, id)

  def get_pointer_by_name(name) do
    Pointer
    |> Repo.get_by(name: name)
  end

  @doc """
  Creates a pointer.

  ## Examples

      iex> create_pointer(%{field: value})
      {:ok, %Pointer{}}

      iex> create_pointer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pointer(attrs \\ %{}) do
    %Pointer{}
    |> Pointer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pointer.

  ## Examples

      iex> update_pointer(pointer, %{field: new_value})
      {:ok, %Pointer{}}

      iex> update_pointer(pointer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pointer(%Pointer{} = pointer, attrs) do
    pointer
    |> Pointer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pointer.

  ## Examples

      iex> delete_pointer(pointer)
      {:ok, %Pointer{}}

      iex> delete_pointer(pointer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pointer(%Pointer{} = pointer) do
    Repo.delete(pointer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pointer changes.

  ## Examples

      iex> change_pointer(pointer)
      %Ecto.Changeset{data: %Pointer{}}

  """
  def change_pointer(%Pointer{} = pointer, attrs \\ %{}) do
    Pointer.changeset(pointer, attrs)
  end
end
