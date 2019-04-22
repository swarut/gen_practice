defmodule RubyCodeGenerator do
  require EEx

  @main_file_content File.read("templates/ruby/ruby_base.eex")
  @spec_file_content File.read("templates/ruby/ruby_spec_base.eex")
  @gem_file_content File.read("templates/ruby/Gemfile")
  @spec_config_file_content File.read("templates/ruby/.rspec")
  @spec_helper_content File.read("templates/ruby/spec_helper.rb")


  def run(name, class_name) do
    IO.puts "Generating base Ruby code."
    System.cmd("mkdir", ["ruby"])
    System.cmd("mkdir", ["spec"], cd: "ruby")

    IO.puts "* Generating base ruby source and spec."
    gen_ruby_gem_file()
    gen_ruby_spec_config_file()
    gen_ruby_spec_helper_file()
    gen_ruby_main_file(name, class_name)
    gen_ruby_spec_file(name, class_name)

    IO.puts "* Running bundle"
    System.cmd("bundle", ["install"], cd: "ruby")
    IO.puts "::Ruby Code Generation Completed::"
  end

  def gen_ruby_main_file(name, class_name) do
    {:ok, file_content} = @main_file_content
    ruby_main_file_output = EEx.eval_string(file_content, name: name, class_name: class_name)
    File.write("ruby/#{name}.rb", ruby_main_file_output)
  end

  def gen_ruby_spec_file(name, class_name) do
    {:ok, file_content} = @spec_file_content
    ruby_spec_file_output = EEx.eval_string(file_content, name: name, class_name: class_name)
    File.write("ruby/spec/#{name}_spec.rb", ruby_spec_file_output)
  end

  def gen_ruby_gem_file do
    {:ok, file_content} = @gem_file_content
    File.write("ruby/Gemfile", file_content)
  end

  def gen_ruby_spec_config_file do
    {:ok, file_content} = @spec_config_file_content
    File.write("ruby/.rspec", file_content)
  end

  def gen_ruby_spec_helper_file do
    {:ok, file_content} = @spec_helper_content
    File.write("ruby/spec/spec_helper.rb", file_content)
  end


end
