# MultiMongoex

A mongo database adapter that can connect to any database by passing configuration at runtime.

If a connection to the database previously been made, it will reuse that connection, otherwise it will start
up a new connection pool to that database.

## Installation

```elixir
def deps do
  [{:multi_mongoex, git: "https://github.com/voxpoplabs/multi_mongoex.git"}]
end
```

## Usage

```
MultiMongoex.execute_command(
  %{
    host: "127.0.0.1",
    db: "test_database"
  }
  command,
  args
)
```

## Available calls

| Command  | Arguments |
| ------------- | ------------- |
| find  | %{ collection: collection, query: query }  |
| find_one  | %{ collection: collection, query: query }  |
| first  | %{ collection: collection }  |
| last  | %{ collection: collection }  |
| count  | %{ collection: collection, query: query }  |
| aggregate  | %{ collection: collection, pipeline: pipeline }  |
| insert_one  | %{ collection: collection, document: document }  |
| insert_many  | %{ collection: collection, documents: documents }  |
| update  | %{ collection: collection, filter: filter, attributes: attributes }  |