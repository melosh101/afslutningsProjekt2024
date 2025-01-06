defmodule ByensHus.Events.UserEvents do
  use Ecto.Schema

  schema "user_events" do
    belongs_to :user, ByensHus.Accounts.User
    belongs_to :event, ByensHus.Events.Event
  end
end
