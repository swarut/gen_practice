defmodule GenPractice.CLI do
  require EEx

  def main(args) do
    [name | _ ] = args
    class_name = String.split(name, "_") |> Enum.map(fn(t) -> String.capitalize(t) end) |>Enum.join

    System.cmd("mkdir", [name])

    RubyCodeGenerator.run(name, class_name)
    ElixirCodeGenerator.run(name)
  end

end
