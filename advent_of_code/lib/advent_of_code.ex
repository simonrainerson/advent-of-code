defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.

  Collection of entry points for each day
  """

  defp print(day, part, solution) do
    IO.puts("Answer to Day #{day} part #{part}: #{solution}")
  end

  @doc """
  Print all answers.

  """
  def all() do
    print(1, 1, Day1.part1())
    print(1, 2, Day1.part2())
    print(2, 1, Day2.part1())
    print(2, 2, Day2.part2())
    print(3, 1, Day3.part1())
    print(3, 2, Day3.part2())
  end
end
