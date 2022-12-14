defmodule Day14 do
  def run() do
    rocks =
      "input.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Stream.flat_map(&parse/1)
      |> MapSet.new()

    ymax = rocks |> Stream.map(fn {_x, y} -> y end) |> Enum.max()

    rocks
    |> Stream.unfold(fn rocks ->
      case drop(rocks, ymax) do
        :abyss -> nil
        still -> {still, MapSet.put(rocks, still)}
      end
    end)
    |> Enum.to_list()
    |> length()
    |> IO.puts()
  end

  defp drop(rocks, ymax, {x, y} \\ {500, 0}) do
    cond do
      y > ymax -> :abyss
      {x, y} in rocks -> :rock
      true ->
        [x, x - 1, x + 1]
        |> Stream.map(fn x -> {x, y + 1} end)
        |> Stream.map(fn pos -> drop(rocks, ymax, pos) end)
        |> Enum.find({x, y}, fn result -> result != :rock end)
    end
  end

  defp parse(line) do
    line
    |> String.split(" -> ")
    |> Stream.map(fn a -> a |> String.split(",") |> Enum.map(&String.to_integer/1) end)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.flat_map(fn
      [[x1, y], [x2, y]] -> Enum.map(x1..x2, &{&1, y})
      [[x, y1], [x, y2]] -> Enum.map(y1..y2, &{x, &1})
      end)
  end
end

Day14.run()
