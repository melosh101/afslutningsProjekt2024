defmodule ByensHus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ByensHusWeb.Telemetry,
      ByensHus.Repo,
      {DNSCluster, query: Application.get_env(:byensHus, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ByensHus.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ByensHus.Finch},
      # Start a worker by calling: ByensHus.Worker.start_link(arg)
      # {ByensHus.Worker, arg},
      # Start to serve requests, typically the last entry
      ByensHusWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ByensHus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ByensHusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
