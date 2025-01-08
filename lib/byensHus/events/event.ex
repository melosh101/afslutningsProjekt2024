defmodule ByensHus.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :title, :string
    field :description, :string
    field :location, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :image, :string
    field :published_at, :utc_datetime
    many_to_many :attendants, ByensHus.Accounts.User,
      join_through: "user_events"
    has_many :posts, ByensHus.Accounts.Posts
  end

  def changeset(test, attrs) do
    test
    |> cast(attrs, [:title, :description, :location, :start_time, :end_time, :image, :published_at])
    |> validate_required([:title, :description, :location, :start_time, :end_time, :image, :published_at])
  end
end
