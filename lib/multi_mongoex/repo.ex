defmodule MultiMongoex.Repo do

  defmacro __using__(_) do
    quote location: :keep do
      def find(conn, args = %{collection: collection, query: query}) do
        Mongo.find(conn, collection, query, limit: args[:limit] || 50)
        |> Enum.to_list
      end

      def find_one(conn, %{collection: collection, query: query}) do
        Mongo.find(conn, collection, query, limit: 1)
        |> Enum.to_list
        |> Enum.at(0)
      end

      def first(conn, %{collection: collection}) do
        Mongo.find(conn, collection, %{}, limit: 1, sort: ["_id": 1])
        |> Enum.to_list
        |> Enum.at(0)
      end

      def last(conn, %{collection: collection}) do
        Mongo.find(conn, collection, %{}, limit: 1, sort: ["_id": -1])
        |> Enum.to_list
        |> Enum.at(0)
      end

      def count(conn, %{collection: collection, query: query}) do
        {:ok, count} = Mongo.count(conn, collection, query)
        count
      end

      def aggregate(conn, args = %{ collection: collection, pipeline: pipeline }) do
        Mongo.aggregate(conn, collection, pipeline, limit: args[:limit] || 50)
        |> Enum.to_list
      end

      def insert_one(conn, %{collection: collection, document: document}) do
        Mongo.insert_one(conn, collection, document)
      end

      def insert_many(conn, %{collection: collection, documents: documents}) do
        Mongo.insert_many(conn, collection, documents)
      end

      def update(conn, %{collection: collection, filter: filter, attributes: attributes }) do
        Mongo.update_one(conn, collection, filter, %{"$set": attributes})
      end
    end
  end

end