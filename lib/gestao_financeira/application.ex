defmodule GestaoFinanceira.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GestaoFinanceiraWeb.Telemetry,
      GestaoFinanceira.Repo,
      {DNSCluster, query: Application.get_env(:gestao_financeira, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GestaoFinanceira.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GestaoFinanceira.Finch},
      # Start a worker by calling: GestaoFinanceira.Worker.start_link(arg)
      # {GestaoFinanceira.Worker, arg},
      # Start to serve requests, typically the last entry
      GestaoFinanceiraWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GestaoFinanceira.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GestaoFinanceiraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
