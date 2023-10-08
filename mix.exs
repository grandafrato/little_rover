defmodule LittleRover.MixProject do
  use Mix.Project

  def project do
    [
      app: :little_rover,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      atomvm: [
        start: LittleRover,
        flash_offset: 0x10100000
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
      {:exatomvm, github: "atomvm/ExAtomVm"}
    ]
  end
end
