defmodule Day3Test do
  use ExUnit.Case

  describe "describe day 3" do
    test "EniginePart.value_for/2" do
      engine_part = %EnginePart{
        value: 321,
        top_left: {4, 3},
        bottom_right: {8, 5}
      }

      symbols = [{1, 1}, {3, 4}, {1, 4}]
      assert 0 = engine_part |> EnginePart.value_for(symbols)
      symbols = [{2, 2}, {5, 4}, {9, 9}]
      assert 321 = engine_part |> EnginePart.value_for(symbols)
      symbols = [{0, 0}, {4, 5}]
      assert 321 = engine_part |> EnginePart.value_for(symbols)
    end

    test "EnginePart.from_sequence/3" do
      %EnginePart{
        value: v,
        top_left: {l, t},
        bottom_right: {r, b}
      } = EnginePart.from_sequence(["1", "2", "4"], 6, 3)

      assert v == 124
      assert l == 5
      assert r == 9
      assert t == 2
      assert b == 4
    end

    test "Day3.parse_input/1" do
      {_engine_parts, symbols} =
        Day3.parse_input([
          "467..114..",
          "...*......",
          "..35..633.",
          "......#...",
          "617*......",
          ".....+.58.",
          "..592.....",
          "......755.",
          "...$.*....",
          ".664.598.."
        ])

      assert {3, 1, "*"} in symbols
      assert {6, 3, "#"} in symbols
      assert {3, 4, "*"} in symbols
      assert {5, 5, "+"} in symbols
      assert {3, 8, "$"} in symbols
      assert {5, 8, "*"} in symbols
    end

    test "Day3.part1/1" do
      assert 4361 =
               Day3.part1([
                 "467..114..",
                 "...*......",
                 "..35..633.",
                 "......#...",
                 "617*......",
                 ".....+.58.",
                 "..592.....",
                 "......755.",
                 "...$.*....",
                 ".664.598.."
               ])
    end

    test "Day3.cog_value/2" do
      cog = {3, 2, "*"}

      ep1 = %EnginePart{
        value: 10,
        top_left: {0, 0},
        bottom_right: {2, 2}
      }

      ep2 = %EnginePart{
        value: 20,
        top_left: {1, 1},
        bottom_right: {4, 3}
      }

      ep3 = %EnginePart{
        value: 30,
        top_left: {2, 2},
        bottom_right: {5, 4}
      }

      ep4 = %EnginePart{
        value: 40,
        top_left: {2, 2},
        bottom_right: {5, 4}
      }

      {num, _} = Day3.cog_value(cog, [ep1])
      assert num == :none
      {num, _} = Day3.cog_value(cog, [ep1, ep2])
      assert num == :one
      {num, val} = Day3.cog_value(cog, [ep1, ep2, ep3])
      assert num == :two
      assert val == 600
      {num, _} = Day3.cog_value(cog, [ep1, ep2, ep3, ep4])
      assert num == :too_many
    end

    test "Day3.part2/1" do
      assert 467_835 ==
               Day3.part2([
                 "467..114..",
                 "...*......",
                 "..35..633.",
                 "......#...",
                 "617*......",
                 ".....+.58.",
                 "..592.....",
                 "......755.",
                 "...$.*....",
                 ".664.598.."
               ])
    end
  end
end
