defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.14.2",
      name: "Issues",
      source_url: "https://github.com/JoseRobertsVery/elixir-sample",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls.html": :test,
        "coveralls.post": :test,
        "coveralls.detail": :test,
        coveralls: :test
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 1.0.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~>0.19.1"},
      {:earmark, "~> 1.2.4"},
      {:excoveralls, "~> 0.15.0", only: :test}
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI,
      output: "issues"
    ]
  end
end
