defmodule Day13 do
  @decoder_key [[[2]], [[6]]]
  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&parse/1)
    |> Stream.map(&elem(&1, 0))
    |> Stream.concat(@decoder_key)
    |> Enum.sort(&compare/2)
    |> Stream.with_index(1)
    |> Stream.filter(fn {a, _} -> a in @decoder_key end)
    |> Stream.map(fn {_, i} -> i end)
    |> Enum.product()
    |> IO.puts()

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
