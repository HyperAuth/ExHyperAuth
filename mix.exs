defmodule HyperAuth.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hyper_auth,
      version: "0.0.1",
      elixir: "~> 1.3",
      description: "Authentication",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: [
        licenses: ["AGPLv3"],
        source_url: "https://github.com/HyperAuth/ExHyperAuth",
        homepage_url: "https://github.com/HyperAuth/ExHyperAuth",
        links: %{
          "Github" => "https://github.com/HyperAuth/ExHyperAuth"
        },
        maintainers: [
          "Jesús Hernández Gormaz"
        ]
      ]
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
      {:exldap, "~> 0.4", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
