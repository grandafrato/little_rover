defmodule LittleRoverTest do
  use ExUnit.Case
  doctest LittleRover

  test "greets the world" do
    assert LittleRover.hello() == :world
  end
end
