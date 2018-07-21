defmodule Bitly.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :bitly,
      version: @version,
      description: description(),
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: [extras: ["README.md"]],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.1"},
      {:poison, "~> 2.0 or ~> 3.0"},
      {:ex_doc, "~> 0.18.1", only: :dev, runtime: false},
      {:exvcr, "~> 0.9.0", only: :test},
      {:excoveralls, "~> 0.9", only: :test}
    ]
  end

  defp description do
    "Bitly API client for Elixir"
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md),
      maintainers: ["Teerawat Lamanchart"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/teerawat1992/bitly-elixir"}
    ]
  end
end
