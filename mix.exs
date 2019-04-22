defmodule GenPractice.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_practice,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      description: "A code generator for programing practice",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Warut Surapat"],
      licenses:    ["MIT"],
      links:       %{"GitHub" => "https://github.com/swarut/gen_practice"}
    ]
  end

  defp escript do
    [main_module: GenPractice.CLI]
  end
end
