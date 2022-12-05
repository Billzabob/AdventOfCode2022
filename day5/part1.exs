defmodule Day5 do

  @height 8

  def run() do
    file =
      "input.txt"
      |> File.read!()
      |> String.split("\n", trim: true)

    blocks =
      file
      |> Stream.take(@height)
      |> Stream.map(&parse/1)
      |> Enum.to_list()
      |> transpose()
      |> Enum.map(&Enum.filter(&1, fn c -> c != "" end))

    commands =
      file
      |> Stream.drop(@height + 1)
      |> Stream.map(&parse_command/1)
      |> Enum.to_list()

    Enum.reduce(commands, blocks, fn {count, from, to}, state ->
      from = from - 1
      to = to - 1
      from_stack = Enum.at(state, from)
      to_stack = Enum.at(state, to)
      {head, new_from} = Enum.split(from_stack, count)
      new_to = Enum.reverse(head) ++ to_stack

      state
      |> List.replace_at(from, new_from)
      |> List.replace_at(to, new_to)
    end)
    |> Enum.map(&hd/1)
    |> Enum.into("")
    |> IO.puts()
  end

  defp parse(line), do:
    line
    |> String.to_charlist()
    |> Enum.chunk_every(4)
    |> Enum.map(&to_string/1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.replace(&1, "[", ""))
    |> Enum.map(&String.replace(&1, "]", ""))

  defp transpose(rows), do:
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)

  defp parse_command(line) do
    rest = String.slice(line, 5..-1)
    {count, rest} = Integer.parse(rest)
    rest = String.slice(rest, 6..-1)
    [from, to] = rest |> String.split(" to ") |> Enum.map(&String.to_integer/1)
    {count, from, to}
  end
end

Day5.run()
