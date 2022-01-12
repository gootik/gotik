defmodule Gotik.Pointers.Pointer do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.URLValidator

  schema "pointers" do
    field :destination, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(pointer, attrs) do
    pointer
    |> cast(attrs, [:name, :destination])
    |> validate_required([:name, :destination])
    |> validate_url(:destination)
  end
end
