defmodule Day10 do
  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.transform(1, &parse/2)
    |> Stream.with_index(1)
    |> Stream.filter(fn {_, i} -> rem(i - 20, 40) == 0 end)
    |> Stream.map(fn {v, i} -> v * i end)
    |> Enum.sum()
    |> IO.puts()

  defp parse("noop", x), do: {[x], x}
  defp parse("addx " <> n, x), do: {[x, x], x + String.to_integer(n)}
end

Day10.run()
