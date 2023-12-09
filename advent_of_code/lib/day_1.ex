defmodule Day1 do
  def part1(stream \\ Inputs.stream(1)) do
    stream
    |> Stream.map(&String.replace(&1, ~r/\D/, ""))
    |> Stream.map(&(String.first(&1) <> String.last(&1)))
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
