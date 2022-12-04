defmodule Day4 do

  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&parse/1)
    |> Stream.filter(fn [[a1, a2], [b1, b2]] ->
      a2 >= b1 && a1 <= b1 || b2 >= a1 && b1 <= a1
    end)
    |> Enum.count()
    |> IO.puts()

  defp parse(line), do:
    line
    |> String.split(",")
    |> Enum.map(fn range ->
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
    end)
end

Day4.run()
