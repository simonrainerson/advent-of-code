defmodule Day2Test do
  use ExUnit.Case

  describe "describe day 2" do
    test "parse_str/1" do
      %Game{id: 1, red: r, green: g, blue: b} =
        Game.parse_str("Game 1: 2 blue, 6 red; 3 green, 2 red, 4 blue")

      assert r == 6
      assert g == 3
      assert b == 4
    end

    test "part1/1" do
      8 =
        Day2.part1([
          "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
          "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
          "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
          "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 4 red",
          "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
        ])
    end

    test "part2/1" do
      2286 =
        Day2.part2([
          "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
          "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
          "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
          "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
          "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
        ])
    end
  end
end
