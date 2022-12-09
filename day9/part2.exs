defmodule Day9 do
  def run() do
    rope = List.duplicate({0, 0}, 10)

    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&parse/1)
    |> Enum.reduce({rope, MapSet.new()}, &move_rope/2)
    |> elem(1)
    |> MapSet.size()
    |> IO.puts()
  end

  defp parse(line) do
    [direction, n] = String.split(line)
    n = String.to_integer(n)
    List.duplicate(direction, n)
  end

  defp move_rope(direction, {[h | rest], positions}) do
    new_head = move(h, direction)
    new_rope = [new_head | rest] |> Enum.scan(&catchup/2)
    tail = List.last(new_rope)
    {new_rope, MapSet.put(positions, tail)}
  end

  defp catchup({c, d}, {a, b}) do
    dx = a - c
    dy = b - d

    if abs(dx) < 2 and abs(dy) < 2 do
      {c, d}
    else
      dx = dx |> clamp(-1, 1)
      dy = dy |> clamp(-1, 1)
      {c + dx, d + dy}
    end
  end

  defp clamp(value, min, max), do: value |> min(max) |> max(min)

  defp move({x, y}, "U"), do: {x, y + 1}
  defp move({x, y}, "D"), do: {x, y - 1}
  defp move({x, y}, "R"), do: {x + 1, y}
  defp move({x, y}, "L"), do: {x - 1, y}
end

Day9.run()
