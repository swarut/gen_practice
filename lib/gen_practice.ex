defmodule GenPractice.CLI do
  require EEx

  defmacro get_file_content(atom_name, file_name) do
    var = Macro.var(atom_name, nil)
    {:ok, text} = File.read(file_name)
    quote do
      unquote(var) = unquote(text)
    end
  end

  def main(args) do
    [name | _ ] = args
    class_name = String.split(name, "_") |> Enum.map(fn(t) -> String.capitalize(t) end) |>Enum.join

    IO.puts "Generating base Ruby code."
    System.cmd("mkdir", ["ruby"])
    System.cmd("mkdir", ["spec"], cd: "ruby")

    IO.puts "* Generating base source and spec."
    gen_ruby_gem_file()
    gen_ruby_spec_config_file()
    gen_ruby_spec_helper_file()
    gen_ruby_main_file(name, class_name)
    gen_ruby_spec_file(name, class_name)

    IO.puts "* Running bundle"
    System.cmd("bundle", ["install"], cd: "ruby")
    IO.puts "::Completed::"
  end

  def gen_ruby_main_file(name, class_name) do
    get_file_content(:ruby_main_file, "templates/ruby/ruby_base.eex")
    ruby_main_file_output = EEx.eval_string(ruby_main_file, name: name, class_name: class_name)
    File.write("ruby/#{name}.rb", ruby_main_file_output)
  end

  def gen_ruby_spec_file(name, class_name) do
    get_file_content(:ruby_spec_file, "templates/ruby/ruby_spec_base.eex")
    ruby_spec_file_output = EEx.eval_string(ruby_spec_file, name: name, class_name: class_name)
    File.write("ruby/spec/#{name}_spec.rb", ruby_spec_file_output)
  end

  def gen_ruby_gem_file do
    get_file_content(:ruby_gem_file, "templates/ruby/Gemfile")
    File.write("ruby/Gemfile", ruby_gem_file)
  end

  def gen_ruby_spec_config_file do
    get_file_content(:ruby_spec_config_file, "templates/ruby/.rspec")
    File.write("ruby/.rspec", ruby_spec_config_file)
  end

  def gen_ruby_spec_helper_file do
    get_file_content(:ruby_spec_helper_file, "templates/ruby/spec_helper.rb")
    File.write("ruby/spec/spec_helper.rb", ruby_spec_helper_file)
  end

end
