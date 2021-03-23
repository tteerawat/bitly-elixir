defmodule Bitly.MixProject do
  use Mix.Project

  @version "0.1.1"

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
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:excoveralls, "~> 0.9", only: :test},
      {:exvcr, "~> 0.10", only: :test},
      {:jason, "~> 1.1"},
      {:tesla, "~> 1.1"}
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
      links: %{"GitHub" => "https://github.com/tteerawat/bitly-elixir"}
    ]
  end
end
