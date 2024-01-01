defmodule Day6Test do
  use ExUnit.Case

  @example_input [
    "Time:      7  15   30",
    "Distance:  9  40  200"
  ]

  describe "Day 6" do
    test "Day6.parse/1" do
      assert [{7, 9}, {15, 40}, {30, 200}] == Day6.parse(@example_input)
    end

    test "Day6.num_ways_to_win/1" do
      assert 4 == Day6.num_ways_to_win({7, 9})
      assert 8 == Day6.num_ways_to_win({15, 40})
      assert 9 == Day6.num_ways_to_win({30, 200})
    end

    test "Day6.part1/1" do
      assert 288 == Day6.part1(@example_input)
    end
  end
end
