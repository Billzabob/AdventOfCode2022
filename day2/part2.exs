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
    move = calc_move(a, b)

    score1 = case result(a, move) do
      :loss -> 0
      :tie -> 3
      :win -> 6
    end

    score2 = case move do
      :rock -> 1
      :paper -> 2
      :scissors -> 3
    end

    score1 + score2
  end

  defp calc_move(a, :draw), do: a
  defp calc_move(:rock, :lose), do: :scissors
  defp calc_move(:rock, :win), do: :paper
  defp calc_move(:paper, :lose), do: :rock
  defp calc_move(:paper, :win), do: :scissors
  defp calc_move(:scissors, :lose), do: :paper
  defp calc_move(:scissors, :win), do: :rock

  defp result(a, a), do: :tie
  defp result(:rock, :scissors), do: :loss
  defp result(:paper, :rock), do: :loss
  defp result(:scissors, :paper), do: :loss
  defp result(_, _), do: :win

  defp convert("A"), do: :rock
  defp convert("B"), do: :paper
  defp convert("C"), do: :scissors
  defp convert("X"), do: :lose
  defp convert("Y"), do: :draw
  defp convert("Z"), do: :win
end

Day2.run()
