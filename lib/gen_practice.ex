defmodule GenPractice.CLI do
  require EEx


  def main(args) do
    [name | _ ] = args
    class_name = String.split(name, "_") |> Enum.map(fn(t) -> String.capitalize(t) end) |>Enum.join

    RubyCodeGenerator.run(name, class_name)
  end

end
