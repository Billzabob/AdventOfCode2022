defmodule Day13 do
  @decoder_key [[[2]], [[6]]]

  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&parse/1)
    |> Stream.map(&elem(&1, 0))
    |> Stream.concat(@decoder_key)
    |> Enum.sort(Day13)
    |> Stream.with_index(1)
    |> Stream.filter(fn {a, _} -> a in @decoder_key end)
    |> Stream.map(fn {_, i} -> i end)
    |> Enum.product()
    |> IO.puts()

  def compare(same, same), do: :eq
  def compare([], _), do: :lt
  def compare(_, []), do: :gt
  def compare([lh | lt], [rh | rt]), do: with :eq <- compare(lh, rh), do: compare(lt, rt)
  def compare(l, r) when is_list(l), do: compare(l, [r])
  def compare(l, r) when is_list(r), do: compare([l], r)
  def compare(l, r) when l < r, do: :lt
  def compare(l, r) when l > r, do: :gt

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
