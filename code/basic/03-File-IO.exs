###
# References:
#   https://hexdocs.pm/elixir/File.html
#   https://hexdocs.pm/elixir/IO.html
#   https://hexdocs.pm/elixir/Path.html
###

defmodule LearnFileIO do
  def are_you_ready do
    case IO.gets("[?] Are you ready to continue? [y|N] ") |> String.trim() |> String.upcase() do
      "Y" ->
        IO.puts("[INFO] OK. Let's go on...")

      "N" ->
        IO.puts("[INFO] Ending the program...")
        System.halt(0)

      _ ->
        are_you_ready()
    end
  end
end

# ) Loop of getting input

LearnFileIO.are_you_ready()

# Here, use ! version of function when available
# So, if there is any errors, we crash the program immediately

# ) CWD, LS

cur_path = File.cwd!()
IO.puts("[INFO] Current DIR: #{cur_path}.")

files = File.ls!()
IO.puts("[INFO] ls in current DIR: #{inspect(files)}.")

# ) Verify folder exists, do RMDIR

if File.exists?("_temp") do
  case IO.gets("[?] `_temp` exist, delete? [Y|n] ") |> String.trim() |> String.upcase() do
    "N" ->
      :ok

    _ ->
      File.rmdir!("_temp")
      IO.puts("[INFO] `_tmp` folder deleted.")
  end
end

# ) MKDIR

IO.puts("[INFO] Make folder in current dir: `_temp`.")
File.mkdir!("_temp")
IO.puts("[INFO] `_temp` folder is created: #{inspect(File.ls!())}")

# ) Prepare data and Wire File

data2write = StreamData.string(:ascii, min_length: 16) |> Enum.take(10)
path_data2write = [cur_path, "_temp", "data2write.txt"] |> Path.join()
string_data2write = data2write |> Enum.join("\n")
IO.puts("[INFO] write data2write into `#{path_data2write}`:\n#{string_data2write}")

File.write!(path_data2write, string_data2write)
IO.gets("[?] Verify file is created (Press any key to continue...)")

# ) Read File with Stream and Compare

# File.stream!/1 default reads file line by line
# Slice each line only takes 16 chars then put into a list
data2read =
  File.stream!(path_data2write) |> Stream.map(&String.slice(&1, 0, 16)) |> Enum.to_list()

unless data2write |> Enum.sort() == data2read |> Enum.sort() do
  raise "data2write != data2read"
end

IO.puts("[INFO] File.stream/1, Verified `data2read` == `data2write`")

# Read the whole file then split each line into a list
data2read = File.read!(path_data2write) |> String.split("\n")

unless data2write |> Enum.sort() == data2read |> Enum.sort() do
  raise "data2write != data2read"
end

IO.puts("[INFO] File.read/1, Verified  `data2read` == `data2write`")

# ) Clean up
case IO.gets("[?] force remove the created folder `_temp` [Y|n]")
     |> String.trim()
     |> String.upcase() do
  "N" ->
    :ok

  _ ->
    File.rm_rf!("_temp")
    IO.puts("[INFO] `_tmp` folder deleted.")
end
