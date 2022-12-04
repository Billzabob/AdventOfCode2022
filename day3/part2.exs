defmodule Day3 do

  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.chunk_every(3)
    |> Stream.map(&IO.inspect/1)
    |> Stream.map(fn [a, b, c] ->
      a
      |> Enum.filter(&Enum.member?(b, &1))
      |> Enum.filter(&Enum.member?(c, &1))
    end)
    |> Stream.map(&Enum.uniq/1)
    |> Stream.map(&IO.inspect/1)
    |> Stream.map(fn [a] -> if a > 96, do: a - 96, else: a - 38 end)
    |> Enum.sum()
    |> IO.puts()
end

Day3.run()
