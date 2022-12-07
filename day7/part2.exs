defmodule Day7 do
  def run() do
    dir =
      "input.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      # Initial state is empty directory map and empty path (as a list)
      |> Enum.reduce({%{}, []}, &dir_sizes/2)
      |> elem(0)

    total = dir["/"]
    free = 70000000 - total
    space_to_free = 30000000 - free

    dir
    |> Map.values()
    |> Enum.filter(& &1 >= space_to_free)
    |> Enum.min()
    |> IO.puts()
  end

  # Don't care about ls since it's always followed by files
  defp dir_sizes("$ ls", state), do: state
  # Don't care about dir since we'll cd into it eventually
  defp dir_sizes("dir " <> _dir, state), do: state
  defp dir_sizes("$ cd /", {dirs, _cwd}), do: {dirs, [""]}
  defp dir_sizes("$ cd ..", {dirs, [_hd | cwd]}), do: {dirs, cwd}
  defp dir_sizes("$ cd " <> dir, {dirs, cwd}), do: {dirs, [dir | cwd]}

  defp dir_sizes(file, {dirs, cwd}) do
    # Don't care about file name since we only care about directory sizes
    [size, _name] = String.split(file)
    size = String.to_integer(size)

    {new_dirs, _} =
      cwd
      |> Enum.reverse()
      |> Enum.reduce({dirs, []}, fn current_dir, {dirs, path} ->
        path_string = path |> Enum.reverse() |> Enum.join("/")
        key = path_string <> "/" <> current_dir
        new_dirs = Map.update(dirs, key, size, fn prev -> prev + size end)
        {new_dirs, [current_dir | path]}
      end)

    {new_dirs, cwd}
  end
end

Day7.run()
