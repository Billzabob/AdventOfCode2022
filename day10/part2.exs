defmodule Day10 do
  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.transform(1, &parse/2)
    |> Stream.with_index(1)
    |> Stream.map(&draw/1)
    |> Stream.chunk_every(40)
    |> Enum.join("\n")
    |> IO.puts()

  defp draw({x, i}), do: if rem(i - 1, 40) in (x - 1)..(x + 1), do: "#", else: " "

  defp parse("noop", x), do: {[x], x}
  defp parse("addx " <> n, x), do: {[x, x], x + String.to_integer(n)}
end

Day10.run()
