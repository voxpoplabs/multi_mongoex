defmodule VplMongoDb.TemporaryAndSoonToBeRemoved do

  defmacro __using__(_) do
    quote location: :keep do
      # use VplMongoDb.Repo

      def instance(id) do
        find_one("instances", _id: GeneralHelpers.Converter.Bson.to_object_id(id))
      end
    end
  end
end