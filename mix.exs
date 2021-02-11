defmodule Viewplex.MixProject do
  use Mix.Project

  @url "https://github.com/thiagomajesk/viewplex"

  def project do
    [
      app: :viewplex,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Thiago Majesk Goulart"],
      licenses: ["AGPL-3.0-only"],
      source_url: @url,
      links: %{"GitHub" => @url},
      files: ~w(lib mix.exs README.md LICENSE)
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.5"},
      {:phoenix_html, "~> 2.14"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.23.0", only: :dev, runtime: false}
    ]
  end
end
