defmodule EnginePart do
  @moduledoc """
  """
  @enforce_keys [:value, :top_left, :bottom_right]
  defstruct @enforce_keys

  @doc """
  Get the value for the engine part, an engine part is only worth something if
  it is next to a symbol.
  """
  def value_for(%EnginePart{value: value, top_left: {l, t}, bottom_right: {r, b}}, symbols) do
    to_check = for x <- l..r, y <- t..b, do: {x, y}

    if Enum.any?(to_check, &(&1 in symbols)) do
      value
    else
      0
    end
  end

  @doc """
  Create an EnginePart from a sequence of string digits,
  a start number (index into the row, i.e. x position) and
  row number, i.e. y position.
  """
  def from_sequence(seq, start, row) do
    %EnginePart{
      value: seq |> Enum.reduce("", fn x, str -> str <> x end) |> String.to_integer(),
      top_left: {start - 1, row - 1},
      bottom_right: {start + Enum.count(seq), row + 1}
    }
  end
end

defmodule Day3 do
  @moduledoc """
  Find numbers adjecent to symbols, orthogonally or diagonally.
  Add these numbers up.
  """

  defp classify(char) do
    char
    |> case do
      "." -> :dot
      x when x in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"] -> :number
      _ -> :symbol
    end
  end

  defp find_engine_parts_and_symbols({text, row}, {engine_parts, symbols}) do
    {_, engine_parts, symbols} =
      text
      |> String.codepoints()
      |> Enum.chunk_by(&classify/1)
      |> Enum.reduce(
        {0, engine_parts, symbols},
        fn sequence, {i, engine_parts, symbols} ->
          next = i + Enum.count(sequence)

          case hd(sequence) |> classify() do
            :dot ->
              {next, engine_parts, symbols}

            :number ->
              {next, [EnginePart.from_sequence(sequence, i, row) | engine_parts], symbols}

            :symbol ->
              {next, engine_parts,
               (sequence
                |> Enum.with_index()
                |> Enum.map(fn {symbol, offset} -> {i + offset, row, symbol} end)) ++ symbols}
          end
        end
      )

    {engine_parts, symbols}
  end

  @doc """
  Parse input into [%EnginePart{}] and [{x, y}]
  """
  def parse_input(stream) do
    stream
    |> Stream.with_index()
    |> Enum.reduce({[], []}, &find_engine_parts_and_symbols/2)
  end

  @doc """
  Solve part1 of Day 3.
  """
  def part1(stream \\ Inputs.stream(3)) do
    {engine_parts, symbols} = parse_input(stream)
    symbols = symbols |> Enum.map(&{elem(&1, 0), elem(&1, 1)})

    engine_parts
    |> Enum.map(&EnginePart.value_for(&1, symbols))
    |> Enum.sum()
  end

  def cog_neighbours(
        cog,
        %EnginePart{value: v, top_left: {l, t}, bottom_right: {r, b}},
        {neighbours, value}
      ) do
    coords = for x <- l..r, y <- t..b, do: {x, y, "*"}

    if cog in coords do
      case neighbours do
        :none -> {:one, v}
        :one -> {:two, v * value}
        _ -> {:too_many, 0}
      end
    else
      {neighbours, value}
    end
  end

  def cog_value(cog, engine_parts) do
    engine_parts
    |> Enum.reduce({:none, 0}, fn ep, val -> cog_neighbours(cog, ep, val) end)
  end

  def part2(stream \\ Inputs.stream(3)) do
    {engine_parts, symbols} = parse_input(stream)

    symbols
    |> Enum.filter(&(elem(&1, 2) == "*"))
    |> Enum.map(&cog_value(&1, engine_parts))
    |> Enum.map(fn {n, value} ->
      case n do
        :two -> value
        _ -> 0
      end
    end)
    |> Enum.sum()
  end
end
