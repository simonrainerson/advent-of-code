defmodule Day4 do
  def parse_line(text) do
    [card, winning_numbers] = text |> String.split("|")
    [card_name, card_numbers] = card |> String.split(":")

    {
      card_name,
      card_numbers |> String.split() |> Enum.map(&String.to_integer/1) |> MapSet.new(),
      winning_numbers |> String.split() |> Enum.map(&String.to_integer/1) |> MapSet.new()
    }
  end

  defp pow2(exp) do
    exp
    |> case do
      x when x > 0 -> Integer.pow(2, x - 1)
      _ -> 0
    end
  end

  def score_card({_, card_numbers, winning_numbers}) do
    card_numbers
    |> MapSet.intersection(winning_numbers)
    |> MapSet.size()
    |> pow2()
  end

  def part1(stream \\ Inputs.stream(4)) do
    stream
    |> Stream.map(&parse_line/1)
    |> Stream.map(&score_card/1)
    |> Enum.sum()
  end
end
