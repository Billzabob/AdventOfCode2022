defmodule Day6 do
  @length 4
  def run(), do:
    "input.txt"
    |> File.read!()
    |> then(&String.to_charlist/1)
    |> Stream.chunk_every(@length, 1)
    |> Enum.find_index(fn a -> length(Enum.uniq(a)) == @length end)
    |> then(fn a -> a + @length end)
    |> IO.puts()
end

Day6.run()
