defmodule ElixirTechChallengeTest do
  use ExUnit.Case

  test "test reservation output" do
    # runnning the test requires you to hit the enter button consistently on test result is displayed in the terminal
    value = ElixirTechChallenge.get_all_reservations()

    assert ElixirTechChallenge.get_all_reservations() == value
  end
end
