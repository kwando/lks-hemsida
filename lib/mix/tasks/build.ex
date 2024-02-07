defmodule Mix.Tasks.Build do
  use Mix.Task
  @impl Mix.Task

  def run(_) do
    Hemsida.build()
    IO.puts("hemsida built successfully!")
  end
end
