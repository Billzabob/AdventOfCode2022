defmodule Day9 do
  def run() do
    rope = for _ <- 0..9, do: {0, 0}

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
    for _ <- 1..n, do: direction
  end

  defp move_rope(direction, {[h | rest], positions}) do
    new_head = move(h, direction)
    new_rope = [new_head | rest] |> Enum.scan(&catchup/2)
    tail = List.last(new_rope)
    {new_rope, MapSet.put(positions, tail)}
  end

  defp catchup({c, d}, {a, b}) do
    if max(abs(a - c), abs(b - d)) < 2 do
      {c, d}
    else
      x = a - c |> min(1) |> max(-1)
      y = b - d |> min(1) |> max(-1)
      {c + x, d + y}
    end
  end

  defp move({x, y}, "U"), do: {x, y + 1}
  defp move({x, y}, "D"), do: {x, y - 1}
  defp move({x, y}, "R"), do: {x + 1, y}
  defp move({x, y}, "L"), do: {x - 1, y}
end

Day9.run()
