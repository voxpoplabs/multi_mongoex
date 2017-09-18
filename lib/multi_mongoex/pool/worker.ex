defmodule MultiMongoex.Pool.Worker do
  use GenServer
  use MultiMongoex.Repo

  require Logger

  def start_link(connection_options) do
    GenServer.start_link(__MODULE__, %{conn: nil, connection_options: connection_options}, [])
  end

  def init(state) do
    {:ok, state}
  end

  defmodule Connector do

    def connect(connection_options) do
      {:ok, client} = Mongo.start_link(
        hostname: connection_options[:host],
        port: connection_options[:port],
        password: connection_options[:password] || "",
        database: connection_options[:db] || 0
      )

      # Wait for mongo connection to be established
      Process.sleep(100)

      client
    end

    @doc """
    Checking process alive or not in case if we don't have connection we should
    connect to redis server.
    """
    def ensure_connection(conn, connection_options) do
      if Process.alive?(conn) do
        conn
      else
        Logger.debug "[Connector] Mongo connection has died, it will renew connection."
        connect(connection_options)
      end
    end
  end

  @doc false
  def handle_call(%{command: command, args: args}, _from, %{conn: nil, connection_options: connection_options}) do
    conn = Connector.connect(connection_options)
    results = apply(MultiMongoex.Pool.Worker, command, [conn, args])
    {:reply, results, %{conn: conn, connection_options: connection_options}}
  end

  @doc false
  def handle_call(%{command: command, args: args}, _from, %{conn: conn, connection_options: connection_options}) do
    conn = Connector.ensure_connection(conn, connection_options)
    results = apply(MultiMongoex.Pool.Worker, command, [conn, args])
    {:reply, results, %{conn: conn, connection_options: connection_options}}
  end

end