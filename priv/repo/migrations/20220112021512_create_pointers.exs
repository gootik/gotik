defmodule Gotik.Repo.Migrations.CreatePointers do
  use Ecto.Migration

  def change do
    create table(:pointers) do
      add :name, :string
      add :destination, :string

      timestamps()
    end
  end
end
