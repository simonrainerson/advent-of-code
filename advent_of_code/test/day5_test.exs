defmodule Day5Test do
  use ExUnit.Case

  @example_input [
    "seeds: 79 14 55 13",
    "",
    "seed-to-soil map:",
    "50 98 2",
    "52 50 48",
    "",
    "soil-to-fertilizer map:",
    "0 15 37",
    "37 52 2",
    "39 0 15",
    "",
    "fertilizer-to-water map:",
    "49 53 8",
    "0 11 42",
    "42 0 7",
    "57 7 4",
    "",
    "water-to-light map:",
    "88 18 7",
    "18 25 70",
    "",
    "light-to-temperature map:",
    "45 77 23",
    "81 45 19",
    "68 64 13",
    "",
    "temperature-to-humidity map:",
    "0 69 1",
    "1 0 69",
    "",
    "humidity-to-location map:",
    "60 56 37",
    "56 93 4",
    ""
  ]

  describe "Day 5" do
    test "string_to_range/1" do
      assert {98..99, -48} == Day5.string_to_range("50 98 2")
      assert {50..97, 2} == Day5.string_to_range("52 50 48")
    end

    test "stream_to_map/1" do
      ranges =
        [
          "something-to-other:",
          "12 23 5",
          "45 12 6",
          ""
        ]
        |> Day5.stream_to_map()
        |> Map.get("something-to-other:")

      assert {23..27, -11} in ranges
      assert {12..17, 33} in ranges

      map =
        [
          "one-to-two map:",
          "12 16 8",
          "44 2 5",
          "",
          "two-to-three map:",
          "15 1 8"
        ]
        |> Day5.stream_to_map()

      one = Map.get(map, "one-to-two map:")
      two = Map.get(map, "two-to-three map:")

      assert {16..23, -4} in one
      assert {2..6, 42} in one
      assert {1..8, 14} in two
    end

    test "string_to_seeds/1" do
      assert [1, 7, 99] == Day5.string_to_seeds("seeds: 1 7 99")
    end

    test "map_seed/2" do
      assert 14 == Day5.map_seed(13, [{12..16, 1}])
      assert 14 == Day5.map_seed(17, [{8..14, 23}, {16..17, -3}])
      assert 15 == Day5.map_seed(15, [{16..24, 14}])
    end

    test "part1/1" do
      assert 35 == Day5.part1(@example_input)
    end

    test "string_to_seed_ranges/1" do
      assert [79..92, 55..67] == Day5.parse_seed_ranges(["seeds: 79 14 55 13"])
    end

    test "part2/1" do
      assert 46 == Day5.part2(@example_input)
    end
  end
end
