defmodule Mayo.Mixfile do
  use Mix.Project

  def project do
    [app: :mayo,
     version: "0.1.0",
     elixir: "~> 1.2",
     description: "Schema validator inspired by Joi",
     deps: deps(),
     package: package()]
  end

  def application do
    []
  end

  defp deps do
    []
  end

  defp package do
    [contributors: "Tommy Chen",
     licenses: ["MIT License"],
     links: %{"GitHub" => "https://github.com/tommy351/mayo"}]
  end
end
