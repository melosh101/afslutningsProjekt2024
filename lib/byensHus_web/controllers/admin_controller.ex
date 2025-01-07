defmodule ByensHusWeb.AdminController do
  alias ByensHus.Accounts.User
  alias ByensHus.Repo
  use ByensHusWeb, :controller
  import Ecto.Changeset

  import Bitwise

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
  def become_admin(conn, _params) do
    user = Repo.get(User, conn.assigns.current_user.id);
    if !User.has_role?(conn.assigns.current_user, :admin) do
      changeset = change(user, %{roles: bor(user.roles, 2)})
      {:ok, _updated_user} = Repo.update(changeset)
      conn |> put_flash(:info, "You are now an admin") |> redirect(to: "/admin")
    else
      conn |> put_flash(:error, "You are already an admin") |> redirect(to: "/admin")
    end
  end
end
