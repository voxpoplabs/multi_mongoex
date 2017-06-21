defmodule MultiMongoex.Mixfile do
  use Mix.Project

  def project do
    [app: :multi_mongoex,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {MultiMongoex.Application, []}]
  end

  defp deps do
    [
      {:mongodb, ">= 0.0.0"},
      {:poolboy, ">= 0.0.0"},
      {:general_helpers, in_umbrella: true}
    ]
  end
end
