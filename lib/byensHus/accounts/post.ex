defmodule ByensHus.Accounts.Posts do
  use Ecto.Schema

  schema "posts" do
    field :title, :string
    field :content, :string
    field :published_at, :utc_datetime
    field :image, :string
    belongs_to :user, ByensHus.Accounts.User
    belongs_to :event, ByensHus.Events.Event
  end
end
