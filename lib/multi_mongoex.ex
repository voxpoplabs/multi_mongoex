defmodule MultiMongoex do

  def execute_command(mongo_setup, command, args) do
    # Lookup mongo and ensure the supervisor is running
    lookup mongo_setup, fn _pid ->

      # Once the supervisor is running, get a mongo worker from poolboy
      :poolboy.transaction(mongo_setup[:name], fn(worker) ->

        # Send the command to the worker genserver which has the connection running
        GenServer.call(worker, %{command: command, args: args})
      end, 5000)
    end
  end

  defp lookup(mongo_setup, callback) do
    case MultiMongoex.Registry.create(MultiMongoex.Registry, mongo_setup) do
      { :ok, pid } -> callback.(pid)
      _ -> { :error, "Registry not working" }
    end
  end

end
