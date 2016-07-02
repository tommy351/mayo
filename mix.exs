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
     docs: [extras: ["README.md"], main: "readme",
            source_ref: @version,
            source_url: @github_link]]
  end

  def application do
    []
  end

  defp deps do
    [{:ex_doc, "~> 0.12", only: :docs}]
  end

  defp package do
    [maintainers: ["Tommy Chen"],
     licenses: ["MIT License"],
     links: %{"GitHub" => @github_link}]
  end
end
