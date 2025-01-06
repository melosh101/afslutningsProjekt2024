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
    has_many :attendants, ByensHus.Accounts.User
    has_many :posts, ByensHus.Accounts.Post
    timestamps(type: :utc_datetime)
  end
end
