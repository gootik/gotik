defmodule Gotik.Pointers.Pointer do
  use Ecto.Schema
  import Ecto.Changeset
  # import EctoCommons.URLValidator

  schema "pointers" do
    field :destination, :string
    field :name, :string

    belongs_to :user, Gotik.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(pointer, attrs) do
    pointer
    |> cast(attrs, [:name, :destination, :user_id])
    |> validate_required([:name, :destination, :user_id])
  end
end
