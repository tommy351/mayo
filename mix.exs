defmodule Mayo.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @github_link "https://github.com/tommy351/mayo"

  def project do
    [app: :mayo,
     version: @version,
     elixir: "~> 1.2",
     description: "Schema validator inspired by Joi",
     deps: deps(),
     package: package(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: preferred_cli_env(),
     docs: [extras: ["README.md"], main: "readme",
            source_ref: @version,
            source_url: @github_link]]
  end

  def application do
    []
  end

  defp deps do
    [{:luhn, "~> 0.3"},
     {:ex_doc, "~> 0.12", only: :docs},
     {:excoveralls, "~> 0.5", only: :test},
     {:inch_ex, "~> 0.5", only: :docs}]
  end

  defp package do
    [maintainers: ["Tommy Chen"],
     licenses: ["MIT License"],
     links: %{"GitHub" => @github_link}]
  end

  defp preferred_cli_env do
    ["coveralls": :test,
     "coveralls.travis": :test,
     "docs": :docs,
     "inchci.add": :docs,
     "inchci.report": :docs]
  end
end
