defmodule Day6 do
  def num_ways_to_win({total_time, record}) do
    term1 = total_time / 2
    term2 = :math.sqrt(total_time ** 2 / 4 - record)
    lower = (term1 - term2 + 1) |> :math.floor() |> Kernel.trunc()
    upper = (term1 + term2 - 1) |> :math.ceil() |> Kernel.trunc()
    1 + upper - lower
  end

  def parse(stream) do
    ["Time:" <> time, "Distance:" <> distance] = stream |> Enum.to_list()

    Enum.zip(
      time |> String.split() |> Enum.map(&String.to_integer/1),
      distance |> String.split() |> Enum.map(&String.to_integer/1)
    )
  end

  def part1(stream \\ Inputs.stream(6)) do
    stream
    |> parse()
    |> Enum.map(&num_ways_to_win/1)
    |> Enum.product()
  end

  def parse_one(stream) do
    ["Time:" <> time, "Distance:" <> distance] = stream |> Enum.to_list()

    {
      time |> String.replace(~r/\W/, "") |> String.to_integer(),
      distance |> String.replace(~r/\W/, "") |> String.to_integer()
    }
  end

  def part2(stream \\ Inputs.stream(6)) do
    stream
    |> parse_one()
    |> num_ways_to_win()
  end
end
