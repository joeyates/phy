defmodule Phy.MixProject do
  use Mix.Project

  @version "0.1.0"
  @scm_url "https://github.com/joeyates/phy"

  def project do
    [
      app: :phy,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        maintainers: ["Joe Yates"],
        licenses: ["MIT"],
        links: %{"GitHub" => @scm_url},
        files: ~w(lib priv/templates mix.exs README.md LICENSE)
      ],
      preferred_cli_env: [docs: :docs],
      source_url: @scm_url,
      docs: docs(),
      homepage_url: @scm_url,
      description: """
      Phy provides a number of generators for Elixir Phoenix projects.
      """
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev},
      {:mox, ">= 0.0.0", only: :test}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      homepage_url: @scm_url,
      source_ref: "v#{@version}",
      source_url: @scm_url
    ]
  end
end
