defmodule ByensHus.Repo.Migrations.AddEventsAndPosts do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :string
      add :location, :string
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :image, :string
      add :published_at, :utc_datetime
    end

    create table(:posts) do
      add :title, :string
      add :content, :string
      add :author, :string
      add :published_at, :utc_datetime
      add :image, :string
      add :user_id, references(:users), null: false
      add :event_id, references(:events), null: false
      add :inserted_at, :utc_datetime
      add :updated_at, :utc_datetime
    end

    create table(:user_events) do
      add :user_id, references(:users), null: false
      add :event_id, references(:events), null: false
    end
  end
end
