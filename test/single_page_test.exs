defmodule SinglePageTest do
  use ExUnit.Case
  doctest SinglePage

  test "greets the world" do
    assert SinglePage.hello() == :world
  end
end
