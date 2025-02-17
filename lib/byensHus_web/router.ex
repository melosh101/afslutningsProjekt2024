defmodule ByensHusWeb.Router do
  use ByensHusWeb, :router

  import ByensHusWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ByensHusWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :require_admin do
    plug :browser
    plug :require_authenticated_user
    plug :user_is_admin
    plug :put_layout, {ByensHusWeb.Layouts, :admin}
  end

  scope "/", ByensHusWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/admin", ByensHusWeb do
    pipe_through :require_admin

    get "/", AdminController, :dashboard
    get "/users", AdminController, :users
    get "/events", AdminController, :events
    get "/booking", AdminController, :booking
  end

  # Other scopes may use custom stacks.
  # scope "/api", ByensHusWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:byens_hus, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ByensHusWeb.Telemetry

    end

    scope "/", ByensHusWeb do
      pipe_through :browser

      get "/become_admin", AdminController, :become_admin
    end
  end

  ## Authentication routes

  scope "/", ByensHusWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{ByensHusWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", ByensHusWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{ByensHusWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", ByensHusWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{ByensHusWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end

  def user_is_admin(conn, _params) do
    if ByensHus.Accounts.User.has_role?(conn.assigns[:current_user], :admin) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access this page.")
      |> redirect(to: "/")
    end
  end
end
