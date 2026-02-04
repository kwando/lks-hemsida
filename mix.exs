defmodule Hemsida.MixProject do
  use Mix.Project

  def project do
    [
      app: :hemsida,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
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
      {:nimble_publisher, "~> 1.1"},
      {:phoenix_live_view, "~> 1.1"},
      {:tailwind, "~> 0.2"},
      {:esbuild, "~> 0.10"}
    ]
  end

  defp aliases do
    [
      "site.build": [
        "build",
        "tailwind default --minify"
        # "esbuild default --minify"
      ]
    ]
  end
end
