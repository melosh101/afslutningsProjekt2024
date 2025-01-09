defmodule ByensHusWeb.PageController do
  use ByensHusWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    event = ByensHus.Events.get_events()
    conn
    |> render(:home, events: event)
  end

  def booking(conn, _params) do
    conn
    |> render(:booking)
  end
end
