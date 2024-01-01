defmodule Day7 do
  def classify_hand({hand, bid}) do
    hand =
      hand
      |> String.to_charlist()
      |> Enum.map(
        &case &1 do
          ?T -> "A"
          ?J -> "B"
          ?Q -> "C"
          ?K -> "D"
          ?A -> "E"
          x -> x
        end
      )

    type =
      hand
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)
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

  def part1(stream \\ Inputs.stream(7)) do
    stream
    |> parse_hands()
    |> Stream.map(&classify_hand/1)
    |> Enum.sort()
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, _, bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end
end
