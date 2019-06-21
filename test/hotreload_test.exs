defmodule HotreloadTest do
  use ExUnit.Case
  doctest Hotreload

  test "greets the world" do
    assert Hotreload.hello() == :world
  end
end
