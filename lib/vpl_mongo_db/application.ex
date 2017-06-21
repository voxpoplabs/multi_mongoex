defmodule VplMongoDb.Application do
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
      worker(VplMongoDb.Registry, []),
      supervisor(VplMongoDb.Pool.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: VplMongoDb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
