defmodule GenPracticeTest do
  use ExUnit.Case
  doctest GenPractice

  test "greets the world" do
    assert GenPractice.hello() == :world
  end
end
