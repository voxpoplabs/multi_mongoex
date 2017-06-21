defmodule MultiMongoex.Poolboy.Supervisor do
  use Supervisor

  # A simple module attribute that stores the supervisor name
  def start_link(mongo_connection_information) do
    Supervisor.start_link(__MODULE__, mongo_connection_information)
  end

  def init(%{ name: name, connection_options: connection_options }) do
    pool_options = [
      name: {:local, name},
      worker_module: MultiMongoex.Pool.Worker,
      size: 10,
      max_overflow: 1
    ]

    children = [
      :poolboy.child_spec(name, pool_options, connection_options)
    ]

    supervise(children, strategy: :one_for_one)
  end


end