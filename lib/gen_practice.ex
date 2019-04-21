defmodule GenPractice.CLI do
  require EEx

  defmacro mac(atom_name) do
    name = Atom.to_string(atom_name)
    var = Macro.var(atom_name, nil)

    {:ok, text} = File.read("templates/ruby/ruby_base.eex")

    out = EEx.eval_string(text, name: name, class_name: "classname")
    quote do
      unquote(var) = unquote(out)
    end
  end

  def main(_args) do
    mac(:output)
    File.write("example.rb", output)
  end






  def gen_ruby_main_file(name) do
    output = get_ruby_output("templates/ruby/ruby_base.eex", name)
    File.write("ruby/#{name}.rb", output)
  end

  def gen_ruby_spec_file(name) do
    output = get_ruby_output("templates/ruby/ruby_spec_base.eex", name)
    File.write("ruby/spec/#{name}_spec.rb", output)
  end

  def get_ruby_output(file_name, name) do
    {:ok, text} = File.read(file_name)
    class_name = String.split(name, "_") |> Enum.map(fn(t) -> String.capitalize(t) end) |>Enum.join
    EEx.eval_string(text, name: name, class_name: class_name)
  end
end
