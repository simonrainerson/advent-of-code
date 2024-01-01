defmodule Day7Test do
  use ExUnit.Case

  @example_input [
    "32T3K 765",
    "T55J5 684",
    "KK677 28",
    "KTJJT 220",
    "QQQJA 483"
  ]

  describe "Day 7" do
    test "Day7.parse_hand/1" do
      hands = Day7.parse_hands(["32T3K 765"]) |> Enum.to_list()
      assert [{"32T3K", 765}] == hands
      hands = Day7.parse_hands(@example_input) |> Enum.to_list()

      assert [
               {"32T3K", 765},
               {"T55J5", 684},
               {"KK677", 28},
               {"KTJJT", 220},
               {"QQQJA", 483}
             ] == hands
    end

    test "Day7.classify_hand/2" do
      assert {2, "32A3D", 765} = Day7.classify_hand({"32T3K", 765})
      assert {4, "A55B5", 684} = Day7.classify_hand({"T55J5", 684})
      assert {3, "DD677", 28} = Day7.classify_hand({"KK677", 28})
      assert {3, "DABBA", 220} = Day7.classify_hand({"KTJJT", 220})
      assert {4, "CCCBE", 483} = Day7.classify_hand({"QQQJA", 483})

      assert {2, "32A3D", 765} = Day7.classify_hand({"32T3K", 765}, true)
      assert {6, "A5515", 684} = Day7.classify_hand({"T55J5", 684}, true)
      assert {3, "DD677", 28} = Day7.classify_hand({"KK677", 28}, true)
      assert {6, "DA11A", 220} = Day7.classify_hand({"KTJJT", 220}, true)
      assert {6, "CCC1E", 483} = Day7.classify_hand({"QQQJA", 483}, true)
    end

    test "sorting" do
      hands =
        @example_input
        |> Day7.parse_hands()
        |> Stream.map(&Day7.classify_hand/1)
        |> Enum.sort(:desc)

      assert [
               {4, "CCCBE", 483},
               {4, "A55B5", 684},
               {3, "DD677", 28},
               {3, "DABBA", 220},
               {2, "32A3D", 765}
             ] == hands

      hands =
        @example_input
        |> Day7.parse_hands()
        |> Stream.map(&Day7.classify_hand(&1, true))
        |> Enum.sort(:desc)

      assert [
               {6, "DA11A", 220},
               {6, "CCC1E", 483},
               {6, "A5515", 684},
               {3, "DD677", 28},
               {2, "32A3D", 765}
             ] == hands
    end

    test "Day7.part1/1" do
      assert 6440 == Day7.part1(@example_input)
    end

    test "Day7.part2/1" do
      assert 5905 == Day7.part2(@example_input)
    end
  end
end
