defmodule Day11 do
  def run() do
    monkeys =
      "input.txt"
      |> File.read!()
      |> String.split("\n\n", trim: true)
      |> Enum.map(&parse/1)

    lcm =
      monkeys
      |> Enum.map(fn %{div: div} -> div end)
      |> Enum.product()

    (&run_round(&1, lcm))
    |> List.duplicate(10_000)
    |> Enum.reduce(monkeys, fn f, m -> f.(m) end)
    |> Enum.map(& &1.count)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
    |> IO.puts()
  end

  defp run_round(monkeys, lcm), do:
    Enum.reduce(1..length(monkeys), monkeys, fn i, monkeys ->
      current = Enum.at(monkeys, i - 1)

      {trues, falses} =
        current.items
        |> Enum.map(current.op)
        |> Enum.map(&rem(&1, lcm))
        |> Enum.split_with(fn v -> rem(v, current.div) == 0 end)

      monkeys
      |> update_in([Access.at(current.i), :count], fn m -> m + length(current.items) end)
      |> update_in([Access.at(current.i), :items], fn _items -> [] end)
      |> update_in([Access.at(current.true_index), :items], fn items -> items ++ trues end)
      |> update_in([Access.at(current.false_index), :items], fn items -> items ++ falses end)
    end)

  defp parse(txt) do
    [a, b, c, d, e, f] = String.split(txt, "\n")
    "Monkey " <> i = a
    "  Starting items: " <> items = b
    "  Operation: new = " <> operation = c
    "  Test: divisible by " <> div = d
    "    If true: throw to monkey " <> true_index = e
    "    If false: throw to monkey " <> false_index = f
    {i, _} = Integer.parse(i)
    items = items |> String.split(", ") |> Enum.map(&String.to_integer/1)
    operation = op(operation)
    div = String.to_integer(div)
    true_index = String.to_integer(true_index)
    false_index = String.to_integer(false_index)
    %{i: i, items: items, op: operation, div: div, true_index: true_index, false_index: false_index, count: 0}
  end

  defp op("old * old"), do: fn a -> a * a end
  defp op("old * " <> num), do: fn a -> a * String.to_integer(num) end
  defp op("old + " <> num), do: fn a -> a + String.to_integer(num) end
end

Day11.run()
