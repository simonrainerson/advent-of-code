defmodule Day1 do
  @moduledoc """
  Day 1, solving coordinate for a trebuchet. Do it by concatenating the first
  and last digit in a string, then sum all strings.
  """

  @doc """
  Take something streamable or read from input for day 1, and calculate the sum
  of first and last digit for each line.
  """
  def part1(stream \\ Inputs.stream(1)) do
    stream
    |> Stream.map(&String.replace(&1, ~r/\D/, ""))
    |> Stream.map(&(String.first(&1) <> String.last(&1)))
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum()
  end

  @doc """
  Return a list of digits in the string, considering named digits.
  """
  def to_numbers(letters) do
    Regex.scan(~r/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/, letters)
    |> Enum.map(&List.last/1)
    |> Enum.map(
      &String.replace(
        &1,
        ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"],
        fn number ->
          case number do
            "one" -> "1"
            "two" -> "2"
            "three" -> "3"
            "four" -> "4"
            "five" -> "5"
            "six" -> "6"
            "seven" -> "7"
            "eight" -> "8"
            "nine" -> "9"
          end
        end
      )
    )
  end

  @doc """
  Same as part1 but also take named digits (e.g. "one" is "1") into account.
  """
  def part2(stream \\ Inputs.stream(1)) do
    stream
    |> Stream.map(&to_numbers/1)
    |> Stream.map(&(List.first(&1) <> List.last(&1)))
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
