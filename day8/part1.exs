defmodule Day8 do
  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn l -> l |> String.to_charlist() |> Enum.map(&{&1, false}) end)
    |> Enum.map(&left_and_right_rays/1)
    |> transpose()
    |> Enum.map(&left_and_right_rays/1)
    |> Enum.map(&Enum.count(&1, fn {_tree, visible} -> visible end))
    |> Enum.sum()
    |> IO.puts()

  defp left_and_right_rays(line) do
    line
    |> ray(-1)
    |> Enum.reverse()
    |> ray(-1)
    |> Enum.reverse()
  end

  defp ray([], _max_so_far), do: []
  defp ray([{tree, _visible} | rest], max_so_far) when max_so_far < tree, do: [{tree, true} | ray(rest, tree)]
  defp ray([{tree, visible} | rest], max_so_far), do: [{tree, visible} | ray(rest, max_so_far)]

  defp transpose(rows), do:
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
end

Day8.run()
