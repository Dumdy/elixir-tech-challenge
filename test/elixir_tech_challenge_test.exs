defmodule ElixirTechChallengeTest do
  use ExUnit.Case
  doctest ElixirTechChallenge

  test "greets the world" do
    assert ElixirTechChallenge.hello() == :world
  end
end
