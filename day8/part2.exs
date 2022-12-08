defmodule Day8 do
  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn l -> l |> String.to_charlist() |> Enum.map(&{&1, 1}) end)
    |> Enum.map(&left_and_right_rays/1)
    |> transpose()
    |> Enum.map(&left_and_right_rays/1)
    |> transpose()
    |> Enum.map(fn l -> l |> Enum.map(fn {_height, score} -> score end) |> Enum.max() end)
    |> Enum.max()
    |> IO.puts()

  defp left_and_right_rays(line) do
    line
    |> ray([])
    |> Enum.reverse()
    |> ray([])
    |> Enum.reverse()
  end

  defp ray([], _prev_list), do: []
  defp ray([{height, _score} | rest], []), do: [{height, 0} | ray(rest, [height])]

  defp ray([{height, prev_score} | rest], prev_list) do
    score = prev_list |> Enum.find_index(& &1 >= height) |> or_else(length(prev_list))
    [{height, score * prev_score} | ray(rest, [height | prev_list])]
  end

  defp or_else(nil, l), do: l
  defp or_else(i, _l), do: i + 1

  defp transpose(rows), do:
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
end

Day8.run()
