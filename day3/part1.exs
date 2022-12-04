defmodule Day3 do

  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.map(fn l -> l |> Enum.split(length(l) |> div(2)) end)
    |> Stream.map(fn {a, b} -> Enum.filter(a, &Enum.member?(b, &1)) end)
    |> Stream.map(&Enum.uniq/1)
    |> Stream.map(fn [a] -> if a > 96, do: a - 96, else: a - 38 end)
    |> Enum.sum()
    |> IO.puts()
end

Day3.run()
