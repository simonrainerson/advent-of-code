defmodule Day1Test do
  use ExUnit.Case

  test "part1/1" do
    assert 142 == Day1.part1(["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"])
  end

  describe "day 1 part 2" do
    test "to_numbers" do
      assert ["1"] == Day1.to_numbers("one")
      assert ["1", "2", "3", "4"] == Day1.to_numbers("1two3four")
      assert ["5"] == Day1.to_numbers("ffffiveeee")
      assert ["1", "8"] == Day1.to_numbers("oneight")
    end

    test "part2/1" do
      assert 281 ==
               Day1.part2([
                 "two1nine",
                 "eightwothree",
                 "abcone2threexyz",
                 "xtwone3four",
                 "4nineeightseven2",
                 "zoneight234",
                 "7pqrstsixteen"
               ])
    end
  end
end
