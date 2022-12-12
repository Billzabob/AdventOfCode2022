defmodule Day12 do
  def run() do
    map =
      "input.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist/1)
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, i} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {char, j} -> {{i, j}, char} end)
      end)
      |> Map.new()

    {start, _} = Enum.find(map, fn {_k, v} -> v == ?S end)
    {finish, _} = Enum.find(map, fn {_k, v} -> v == ?E end)

    map
    |> Map.put(start, ?a)
    |> Map.put(finish, ?z)
    |> bfs([start], MapSet.new(), 1, finish)
    |> IO.puts()
  end

  defp bfs(map, current, visited, score, finish) do
    tiles = current |> Enum.flat_map(&get_adjacents(&1, map, visited)) |> Enum.uniq()
    visited = MapSet.union(visited, MapSet.new(tiles))

    cond do
      finish in tiles -> score
      tiles == [] -> nil
      true -> bfs(map, tiles, visited, score + 1, finish)
    end
  end

  defp get_adjacents({x, y}, map, visited) do
    [{x + 1, y}, {x, y + 1}, {x - 1, y}, {x, y - 1}]
    |> Enum.filter(fn k -> k not in visited end)
    |> Enum.filter(fn k -> map[k] <= map[{x, y}] + 1 end)
  end
end

Day12.run()
