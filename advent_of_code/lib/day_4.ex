defmodule Day4 do
  def parse_line(text) do
    [card_name, card_numbers, winning_numbers] = text |> String.split([":", "|"])

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

  def accumulate_cards({{_, numbers, winning}, index}, card_amounts) do
    new_cards = numbers |> MapSet.intersection(winning) |> MapSet.size()

    {mult, card_amounts} =
      card_amounts
      |> Map.get_and_update(index, fn cur ->
        case cur do
          nil -> {1, 1}
          x -> {x + 1, x + 1}
        end
      end)

    if new_cards > 0 do
      1..new_cards
      |> Enum.reduce(card_amounts, fn windex, card_map ->
        Map.update(card_map, index + windex, mult, &(&1 + mult))
      end)
    else
      card_amounts
    end
  end

  def part2(stream \\ Inputs.stream(4)) do
    stream
    |> Stream.map(&parse_line/1)
    |> Stream.with_index()
    |> Enum.reduce(%{}, &accumulate_cards/2)
    |> Map.values()
    |> Enum.sum()
  end
end
