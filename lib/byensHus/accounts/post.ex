defmodule ByensHus.Accounts.Posts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string
    field :author, :string
    field :published_at, :utc_datetime
    field :image, :string
    belongs_to :user, ByensHus.Accounts.User
    timestamps(type: :utc_datetime)
  end
end
