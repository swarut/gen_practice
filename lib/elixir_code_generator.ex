defmodule ElixirCodeGenerator do
  def run(name) do
    IO.puts "Generating base Elixir code."
    System.cmd("mkdir", ["#{name}/elixir"])
    IO.puts "* Running mix"
    System.cmd("mix", ["new", name], cd: "#{name}/elixir")
  end
end
