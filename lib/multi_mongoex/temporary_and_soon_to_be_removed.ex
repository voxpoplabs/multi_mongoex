defmodule MultiMongoex.TemporaryAndSoonToBeRemoved do

  defmacro __using__(_) do
    quote location: :keep do
      # use MultiMongoex.Repo

      def instance(id) do
        find_one("instances", _id: MultiMongoex.Helpers.to_object_id(id))
      end
    end
  end
end