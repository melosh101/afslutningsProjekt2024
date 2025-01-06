defmodule ByensHusWeb.AdminController do
  use ByensHusWeb, :controller
  def dashboard(conn, _params) do
    render(conn, :index)
  end

  def users(conn, _params) do
    render(conn, :users)
  end

  def events(conn, _params) do
    render(conn, :events)
  end

  def booking(conn, _params) do
    render(conn, :booking)
  end
end
