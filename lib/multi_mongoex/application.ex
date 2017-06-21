defmodule MultiMongoex.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # worker(Mongo, [[
      #   name: Application.get_env(:vpl_mongo_db, :name),
      #   hostname: Application.get_env(:vpl_mongo_db, :hostname),
      #   database: Application.get_env(:vpl_mongo_db, :database),
      #   pool: Application.get_env(:vpl_mongo_db, :pool)
      # ]]),
      worker(MultiMongoex.Registry, []),
      supervisor(MultiMongoex.Pool.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: MultiMongoex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
