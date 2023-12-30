defmodule Day5 do
  @seeds_prefix "seeds:"

  def string_to_range(string) do
    [dest_start, source_start, length] =
      string |> String.split() |> Enum.map(&String.to_integer/1)

    [source_start..(source_start + length - 1), dest_start]
  end

  def chunker("", :new) do
    {:cont, :new}
  end

  def chunker("", {key, values}) do
    {:cont, %{key => values |> Enum.map(&string_to_range/1)}, :new}
  end

  def chunker(elem, :new) do
    {:cont, {elem, []}}
  end

  def chunker(elem, {key, values}) do
    {:cont, {key, [elem | values]}}
  end

  def stream_to_map(stream) do
    stream
    |> Stream.chunk_while(:new, &chunker/2, &chunker("", &1))
    |> Enum.reduce(%{}, &Map.merge/2)
  end

  def string_to_seeds(@seeds_prefix <> seeds) do
    String.split(seeds) |> Enum.map(&String.to_integer/1)
  end

  def map_seed(seed, mappings) do
    case mappings |> Enum.find(fn ranges -> seed in Enum.fetch!(ranges, 0) end) do
      nil ->
        seed

      [source, dest] ->
        index = Enum.find_index(source, fn s -> s == seed end)
        dest + index
    end
  end

  def part1(stream \\ Inputs.stream(5)) do
    seeds =
      stream
      |> Stream.take_while(&String.starts_with?(&1, @seeds_prefix))
      |> Enum.to_list()
      |> hd
      |> string_to_seeds()

    maps =
      stream
      |> Stream.drop_while(&String.starts_with?(&1, @seeds_prefix))
      |> stream_to_map()

    seeds
    |> Stream.map(&map_seed(&1, maps["seed-to-soil map:"]))
    |> Stream.map(&map_seed(&1, maps["soil-to-fertilizer map:"]))
    |> Stream.map(&map_seed(&1, maps["fertilizer-to-water map:"]))
    |> Stream.map(&map_seed(&1, maps["water-to-light map:"]))
    |> Stream.map(&map_seed(&1, maps["light-to-temperature map:"]))
    |> Stream.map(&map_seed(&1, maps["temperature-to-humidity map:"]))
    |> Stream.map(&map_seed(&1, maps["humidity-to-location map:"]))
    |> Enum.min()
  end
end
