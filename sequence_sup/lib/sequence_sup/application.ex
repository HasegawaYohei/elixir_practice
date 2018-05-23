defmodule SequenceSup.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    { :ok, _pid } = SequenceSup.Supervisor.start_link(123)
    # import Supervisor.Spec, warn: false

    # # Define workers and child supervisors to be supervised
    # children = [
    #   worker(SequenceSup.Server, [123]),
    # ]

    # # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # # for other strategies and supported options
    # opts = [strategy: :one_for_one, name: SequenceSup.Supervisor]
    # Supervisor.start_link(children, opts)
  end
end
