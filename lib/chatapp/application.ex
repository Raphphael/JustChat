defmodule Chatapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  #This code defines a module which is an OTP (Open Telecom Platform) application. An OTP application is a supervision tree that is used to manage a group of processes in a fault-tolerant manner.
  use Application
  #The start function is called when the application starts and it defines the children processes that will be part of the supervision tree.
  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Chatapp.Repo,
      # Start the Telemetry supervisor
      ChatappWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chatapp.PubSub},
      # Start the Endpoint (http/https)
      ChatappWeb.Endpoint
      # Start a worker by calling: Chatapp.Worker.start_link(arg)
      # {Chatapp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chatapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
