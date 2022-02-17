defmodule LearningElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :learning_elixir,
      version: "0.1.0",
      elixir: "~> 1.13.2",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:stream_data, "~> 0.5.0"},
      {:benchee, "~> 1.0"}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
