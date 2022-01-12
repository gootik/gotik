defmodule Gotik.PointersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gotik.Pointers` context.
  """

  @doc """
  Generate a pointer.
  """
  def pointer_fixture(attrs \\ %{}) do
    {:ok, pointer} =
      attrs
      |> Enum.into(%{
        destination: "some destination",
        name: "some name"
      })
      |> Gotik.Pointers.create_pointer()

    pointer
  end
end
