defmodule ByensHus.Events do
  alias ByensHus.Events.Event
  alias ByensHus.Repo
  import Ecto.Query, warn: false

  def get_event_count do
    length(Repo.all(Event))
  end


end
