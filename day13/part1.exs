defmodule Day13 do
  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> Stream.map(&compare/1)
    |> Stream.with_index(1)
    |> Stream.filter(fn {a, _} -> a end)
    |> Stream.map(fn {_, i} -> i end)
    |> Enum.sum()
    |> IO.puts()

  defp compare(line) do
    [left, right] = line |> String.split("\n", trim: true) |> Enum.map(&parse/1) |> Enum.map(&elem(&1, 0))
    compare(left, right)
  end

  defp compare(same, same), do: :eq
  defp compare([], _), do: true
  defp compare(_, []), do: false
  defp compare([lh | lt], [rh | rt]), do: with :eq <- compare(lh, rh), do: compare(lt, rt)
  defp compare(l, r) when is_list(l), do: compare(l, [r])
  defp compare(l, r) when is_list(r), do: compare([l], r)
  defp compare(l, r), do: l < r

  defp parse("[]" <> rest), do: {[], rest}
  defp parse("[" <> rest) do
    {list, rest} = parse_list([], rest)
    {Enum.reverse(list), rest}
  end

  defp parse(string), do: Integer.parse(string)

  defp parse_list(list, rest) do
    {item, rest} = parse(rest)
    case rest do
      "]" <> rest -> {[item | list], rest}
      "," <> rest -> parse_list([item | list], rest)
    end
  end
end

Day13.run()
