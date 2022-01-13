defmodule Gotik.Repo.Migrations.AddPointerOwner do
  use Ecto.Migration

  def change do
    alter table(:pointers) do
      add :user_id, references(:users)
    end
  end
end
