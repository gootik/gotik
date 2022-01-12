defmodule Gotik.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Gotik.Repo,
      # Start the Telemetry supervisor
      GotikWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gotik.PubSub},
      # Start the Endpoint (http/https)
      GotikWeb.Endpoint
      # Start a worker by calling: Gotik.Worker.start_link(arg)
      # {Gotik.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gotik.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GotikWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
