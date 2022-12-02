"input.txt"
|> File.read!()
|> String.split("\n\n")
|> Enum.map(fn elf ->
  elf
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end)
|> Enum.sort(:desc)
|> Enum.take(3)
|> Enum.sum()
|> IO.puts()
