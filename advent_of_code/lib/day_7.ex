defmodule Day7 do
  def classify_hand({hand, bid}, jokers \\ false) do
    hand =
      hand
      |> String.to_charlist()
      |> Enum.map(
        &case &1 do
          ?T -> "A"
          ?J -> if jokers, do: "1", else: "B"
          ?Q -> "C"
          ?K -> "D"
          ?A -> "E"
          x -> x
        end
      )

    {jokers, non_jokers} = hand |> Enum.split_with(&(&1 == "1"))
    jokers = jokers |> Enum.count()

    type =
      non_jokers
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)
      |> Kernel.then(fn list ->
        if list == [] do
          [5]
        else
          [hd(list) + jokers | tl(list)]
        end
      end)
      |> case do
        [5] -> 7
        [4, 1] -> 6
        [3, 2] -> 5
        [3 | _] -> 4
        [2, 2, 1] -> 3
        [2 | _] -> 2
        _ -> 1
      end

    {type, List.to_string(hand), bid}
  end

  def parse_hands(stream) do
    stream
    |> Stream.map(&String.split/1)
    |> Stream.map(fn [hand, bid] -> {hand, String.to_integer(bid)} end)
  end

  def solve(stream, jokers \\ false) do
    stream
    |> parse_hands()
    |> Stream.map(&classify_hand(&1, jokers))
    |> Enum.sort()
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, _, bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end

  def part1(stream \\ Inputs.stream(7)) do
    stream |> solve()
  end

  def part2(stream \\ Inputs.stream(7)) do
    stream |> solve(true)
  end
end
