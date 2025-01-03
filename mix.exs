defmodule SinglePage.MixProject do
  use Mix.Project
  @version "0.1.1"
  @url "https://github.com/RobertDober/single_page"

  def project do
    [
      app: :single_page,
      version: @version,
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: escript_config(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Interpret an EEx template with html and markdown specific helpers",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls],
      aliases: [docs: &build_docs/1]
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
      {:dialyxir, "~> 1.4.3", only: [:dev], runtime: false},
      {:earmark, "~> 1.4.47"},
      {:ex_aequo, "~> 0.6.7"},
      {:excoveralls, "~> 0.18.1", only: [:test]},
    ]
  end

  defp escript_config do
    [main_module: SinglePage.Cli]
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "LICENSE"
      ],
      maintainers: [
        "Robert Dober <robert.dober@gmail.com>"
      ],
      licenses: [
        "AGPL-3.0-or-later"
      ],
      links: %{
        "GitHub" => @url
      }
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  @module "SinglePage"

  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.path_for(:escripts), "ex_doc")
    Mix.shell().info("Using escript: #{ex_doc} to build the docs")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed, " <>
              "make sure to run `mix escript.install hex ex_doc` before"
    end

    args = [@module, @version, Mix.Project.compile_path()]
    opts = ~w[--main #{@module} --source-ref v#{@version} --source-url #{@url}]

    Mix.shell().info("Running: #{ex_doc} #{inspect(args ++ opts)}")
    System.cmd(ex_doc, args ++ opts)
    Mix.shell().info("Docs built successfully")
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
