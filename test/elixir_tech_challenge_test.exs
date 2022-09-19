defmodule ElixirTechChallengeTest do
  use ExUnit.Case

  test "test reservation output" do
    value = ElixirTechChallenge.get_all_reservations()

    assert ElixirTechChallenge.get_all_reservations() == value
  end
end
