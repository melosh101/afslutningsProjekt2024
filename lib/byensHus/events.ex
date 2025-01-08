defmodule ByensHus.Events do
  alias ByensHus.Events.Event
  alias ByensHus.Repo
  import Ecto.Query, warn: false

  def get_event_count do
    length(Repo.all(Event))
  end

  def get_event_by_id(id) do
    Repo.get(Event, id)
  end

  def get_event_by_string(search) do
    q = "%#{search}%"
    from e in Event,
      where: like(e.title, ^q) or like(e.description, ^q) and e.start_time <= ^DateTime.utc_now(:second),
      order_by: [desc: e.start_time],
      select: e
  end

  def get_events do
    from(e in Event,
      order_by: [desc: :start_time],
      where: e.start_time > ^DateTime.utc_now()
    )
    |> Repo.all()
  end

  @doc """
  Get events with a limit

  """
  def get_events(limit) do
    from(e in Event,
      order_by: [desc: :start_time],
      where: e.start_time > ^DateTime.utc_now(),
      limit: ^limit
    )
    |> Repo.all()
  end

end
