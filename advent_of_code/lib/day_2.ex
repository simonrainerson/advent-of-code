defmodule Game do
  @enforce_keys [:id]
  defstruct id: 0, red: 0, green: 0, blue: 0

  defp insert_if_higher([num, color], game) do
    {_, game} =
      game
      |> Map.get_and_update(String.to_atom(color), &{&1, max(&1, String.to_integer(num))})

    game
  end

  defp parse_game(game, text) do
    text
    |> String.trim()
    |> String.split(" ")
    |> insert_if_higher(game)
  end

  def parse_str(line) do
    [id | cubes] = line |> String.split(":")

    game = %Game{
      id: id |> String.replace(~r/\D/, "") |> String.to_integer()
    }

    cubes
    |> List.first()
    |> String.split(";")
    |> Enum.flat_map(&String.split(&1, ","))
    |> Enum.reduce(game, fn cubes, game -> parse_game(game, cubes) end)
  end
end

defmodule Day2 do
  def part1(stream \\ Inputs.stream(2)) do
    red = 12
    green = 13
    blue = 14

    stream
    |> Stream.map(&Game.parse_str/1)
    |> Stream.filter(
      &(Map.get(&1, :red) <= red and Map.get(&1, :green) <= green and Map.get(&1, :blue) <= blue)
    )
    |> Stream.map(&Map.get(&1, :id))
    |> Enum.sum()
  end
end
