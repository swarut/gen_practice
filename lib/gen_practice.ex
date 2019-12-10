defmodule GenPractice.CLI do
  require EEx

  def main(args) do
    [name | _ ] = args
    System.cmd("mkdir", [name])
    case args do
      [name, "--only-elixir" | _ ] ->
        ElixirCodeGenerator.run(name)
      [name, "--only-ruby" | _] ->
        cname = class_name(name)
        RubyCodeGenerator.run(name, cname)
      [name | _ ] ->
        cname = class_name(name)
        RubyCodeGenerator.run(name, cname)
        ElixirCodeGenerator.run(name)
    end
  end

  def class_name(name) do
    String.split(name, "_") |> Enum.map(fn(t) -> String.capitalize(t) end) |>Enum.join
  end

end
