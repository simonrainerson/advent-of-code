defmodule Inputs do
  def stream(day) do
    File.stream!("../inputs/day#{day}.txt", encoding: :utf8, trim_bom: true)
    |> Stream.map(&String.trim/1)
  end
end
