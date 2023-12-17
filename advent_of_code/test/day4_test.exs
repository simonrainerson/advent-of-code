defmodule Day4Test do
  use ExUnit.Case

  @scratch_cards [
    "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
    "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
    "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
    "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
    "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
    "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"
  ]

  describe "describe day 4" do
    test "Day4.parse_line/1" do
      {card_name, card_numbers, winning_numbers} =
        Day4.parse_line("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")

      assert "Card 1" == card_name
      assert MapSet.new([41, 48, 83, 86, 17]) == card_numbers
      assert MapSet.new([83, 86, 6, 31, 17, 9, 48, 53]) == winning_numbers
    end

    test "Day4.score_card/1" do
      assert 0 == Day4.score_card({"Card 2", MapSet.new([1, 2, 3]), MapSet.new([4, 5, 6])})
      assert 1 == Day4.score_card({"Card 2", MapSet.new([1, 2, 3]), MapSet.new([3, 4, 5, 6])})
      assert 2 == Day4.score_card({"Card 2", MapSet.new([1, 2, 3]), MapSet.new([2, 3, 4, 5, 6])})
      assert 4 == Day4.score_card({"Card 2", MapSet.new([1, 2, 3]), MapSet.new([3, 2, 1])})
    end

    test "EniginePart.value_for/2" do
      assert 13 == Day4.part1(@scratch_cards)
    end

    test "Day4.accumulate_cards/2" do
      card_map =
        Day4.accumulate_cards(
          {{"Game Uno", MapSet.new([1, 2, 3]), MapSet.new([2, 3, 4])}, 0},
          %{}
        )

      assert %{0 => 1, 1 => 1, 2 => 1} == card_map

      card_map =
        Day4.accumulate_cards(
          {{"Game 2", MapSet.new([1, 2, 3]), MapSet.new([2, 3, 4])}, 1},
          card_map
        )

      assert %{0 => 1, 1 => 2, 2 => 3, 3 => 2} == card_map

      card_map =
        Day4.accumulate_cards(
          {{"Game Three", MapSet.new([7, 8, 9]), MapSet.new([1, 2, 3])}, 2},
          card_map
        )

      assert %{0 => 1, 1 => 2, 2 => 4, 3 => 2} == card_map
    end

    test "Day4.part2/1" do
      assert 30 == Day4.part2(@scratch_cards)
    end
  end
end
