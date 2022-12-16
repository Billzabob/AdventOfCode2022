defmodule Day15 do
  @row 2_000_000

  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&parse/1)
    |> Stream.map(fn {s, b} -> {s, b, dist(s, b)} end)
    |> Stream.filter(fn {{_sx, sy}, _b, d} -> sy - @row <= d end)
    |> Enum.reduce(MapSet.new(), fn {{sx, _sy} = s, b, d}, set ->
      (sx - d)..(sx + d)
      |> Enum.map(&{&1, @row})
      |> Enum.filter(fn pos -> dist(pos, s) <= d and pos != b end)
      |> MapSet.new()
      |> MapSet.union(set)
    end)
    |> MapSet.size()
    |> IO.puts()

  defp dist({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  defp parse(line) do
    "Sensor at x=" <> sx = line
    {sx, rest} = Integer.parse(sx)
    ", y=" <> sy = rest
    {sy, rest} = Integer.parse(sy)
    ": closest beacon is at x=" <> bx = rest
    {bx, rest} = Integer.parse(bx)
    ", y=" <> by = rest
    {by, ""} = Integer.parse(by)
    {{sx, sy}, {bx, by}}
  end
end

Day15.run()
