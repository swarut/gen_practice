defmodule GenPractice.CLI do
  require EEx

  defmacro mac(atom_name) do
    name = Atom.to_string(atom_name)
    var = Macro.var(atom_name, nil)

    {:ok, text} = File.read("templates/ruby/ruby_base.eex")

    out = EEx.eval_string(text, name: name, class_name: "classname")
    quote do
      # unquote(var) = unquote(rendered_content)
      unquote(var) = unquote(out)
    end
  end

  def run do
    mac(:output)
    IO.puts(output)
  end

  def main(args) do
    # [name | _ ] = args
    # IO.puts "Generating base Ruby code."
    # System.cmd("mkdir", ["ruby"])
    # System.cmd("mkdir", ["spec"], cd: "ruby")
    # System.cmd("cp", ["templates/ruby/Gemfile", "ruby"])
    # System.cmd("cp", ["templates/ruby/.rspec", "ruby"])
    # System.cmd("cp", ["templates/ruby/spec_helper.rb", "ruby/spec"])
    # IO.puts "* Generating base source and spec."
    # gen_ruby_main_file(name)
    # gen_ruby_spec_file(name)

    # IO.puts "* Running bundle"
    # System.cmd("bundle", ["install"], cd: "ruby")
    # IO.puts "::Completed::"
    run()
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
