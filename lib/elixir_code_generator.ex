defmodule ElixirCodeGenerator do
  def run(name) do
    IO.puts "Generating base Elixir code."
    System.cmd("mkdir", ["elixir"])
    IO.puts "* Running mix"
    System.cmd("mix", ["new", name], cd: "elixir")
  end
end
