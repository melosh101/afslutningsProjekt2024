defmodule ByensHus.Events.UserEvents do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_events" do
    belongs_to :user, ByensHus.Accounts.User
    belongs_to :event, ByensHus.Events.Event
  end
end
