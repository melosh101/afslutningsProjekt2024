defmodule ByensHus.Repo.Migrations.AddProfilePicture do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :profile_picture, :string
    end
  end
end
