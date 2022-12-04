defmodule Day2 do

  def run(), do:
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(fn l -> l |> String.split() |> Enum.map(&convert/1) end)
    |> Stream.map(fn [a, b] -> calc_score(a, b) end)
    |> Enum.sum()
    |> IO.puts()

  defp calc_score(a, b) do
    score1 = case result(a, b) do
      :loss -> 0
      :tie -> 3
      :win -> 6
    end

    score2 = case b do
      :rock -> 1
      :paper -> 2
      :scissors -> 3
    end

    score1 + score2
  end

  defp result(a, a), do: :tie
  defp result(:rock, :scissors), do: :loss
  defp result(:paper, :rock), do: :loss
  defp result(:scissors, :paper), do: :loss
  defp result(_, _), do: :win

  defp convert("A"), do: :rock
  defp convert("B"), do: :paper
  defp convert("C"), do: :scissors
  defp convert("X"), do: :rock
  defp convert("Y"), do: :paper
  defp convert("Z"), do: :scissors
end

Day2.run()
