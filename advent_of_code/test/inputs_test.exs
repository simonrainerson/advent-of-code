defmodule InputsTest do
  use ExUnit.Case

  test "stream/1" do
    oneline =
      Inputs.stream(:test)
      |> Enum.join(" ")

    assert oneline == "line1 line2"
  end
end
