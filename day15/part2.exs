defmodule Day15 do
  defmodule Sensor, do: defstruct [:point, :dist]
  defmodule Point, do: defstruct [:x, :y]
  defmodule Line, do: defstruct [:m, :b]

  def run() do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&parse/1)
    |> Stream.map(fn {s, b} -> %Sensor{point: s, dist: dist(s, b)} end)
    |> then(&combinations/1)
    # Find all sensors that have a gap of 2 between them, this is where the solution will be
    |> Stream.filter(fn {p1, p2} -> dist(p1.point, p2.point) - p1.dist - p2.dist - 2 == 0 end)
    # Calculate the line that runs along the empty space between the two sensors
    |> Stream.map(fn {p1, p2} -> line_dividing_sensors(p1, p2) end)
    |> Enum.sort_by(fn %Line{m: m} -> m end)
    # Find the intersection of those two lines, this yields the result!
    |> then(fn [l1, l2] -> intersection(l1, l2) end)
    |> then(fn %Point{x: x, y: y} -> x * 4_000_000 + y end)
    |> IO.puts()
  end

  defp combinations(all), do:
    for p1 <- all, p2 <- all, p1 != p2 and p1.point.x < p2.point.x, do: {p1, p2}

  defp line_dividing_sensors(p1 = %Sensor{}, p2 = %Sensor{}) do
    x = p1.point.x + p1.dist + 1
    slope = if p1.point.y > p2.point.y, do: 1, else: -1
    b = p1.point.y - slope * x
    %Line{m: slope, b: b}
  end

  defp intersection(%Line{b: b1}, %Line{b: b2}) do
    x = (b1 - b2) |> div(2)
    y = (b1 + b2) |> div(2)
    %Point{x: x, y: y}
  end

  defp dist(%Point{x: x1, y: y1}, %Point{x: x2, y: y2}), do: abs(x1 - x2) + abs(y1 - y2)

  defp parse(line) do
    "Sensor at x=" <> sx = line
    {sx, rest} = Integer.parse(sx)
    ", y=" <> sy = rest
    {sy, rest} = Integer.parse(sy)
    ": closest beacon is at x=" <> bx = rest
    {bx, rest} = Integer.parse(bx)
    ", y=" <> by = rest
    {by, ""} = Integer.parse(by)
    {%Point{x: sx, y: sy}, %Point{x: bx, y: by}}
  end
end

Day15.run()
