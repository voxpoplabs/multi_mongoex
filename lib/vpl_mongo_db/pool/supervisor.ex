defmodule VplMongoDb.Pool.Supervisor do
  use Supervisor

  # A simple module attribute that stores the supervisor name
  @name VplMongoDb.Pool.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_mongo_connection(mongo_connection_information) do
    Supervisor.start_child(@name, [mongo_connection_information])
  end

  def init(:ok) do
    children = [
      supervisor(VplMongoDb.Poolboy.Supervisor, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end