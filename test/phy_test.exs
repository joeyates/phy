defmodule PhyTest do
  use ExUnit.Case
  doctest Phy

  test "greets the world" do
    assert Phy.hello() == :world
  end
end
