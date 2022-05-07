defmodule Gotik.Repo.Migrations.AddPointerUniqueness do
  use Ecto.Migration

  def change do
    create unique_index(:pointers, [:name])
  end
end
