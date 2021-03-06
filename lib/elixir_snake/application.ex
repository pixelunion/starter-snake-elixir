defmodule ElixirSnake.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ElixirSnake.Worker.start_link(arg)
      Plug.Adapters.Cowboy2.child_spec(scheme: :http, plug: ElixirSnake.Router, options: [port: Application.get_env(:elixir_snake, :cowboy_port)])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirSnake.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
