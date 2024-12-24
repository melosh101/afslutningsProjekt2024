defmodule ByensHus.Repo.Migrations.AddUserRoles do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :roles, :integer, default: 1, null: false
    end
  end
end
