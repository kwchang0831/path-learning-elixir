###
# Dependencies:
#   https://hexdocs.pm/stream_data/StreamData.html
#   https://hexdocs.pm/benchee/readme.html
###

# Benchmark different ways to access map with given key
# Access random 1_000 keys from a map contains half a million keys

# 1) Define benchmark functions

defmodule Benchmark.Map.AccessThruBracket do
  def get(map, key) do
    map[key]
  end
end

defmodule Benchmark.Map.MapGet do
  def get(map, key) do
    Map.get(map, key)
  end
end

defmodule Benchmark.Map.MapTake do
  def get(map, key) do
    Map.take(map, [key])
  end
end

defmodule Benchmark.Map.MapFetch do
  def get(map, key) do
    {:ok, output} = Map.fetch(map, key)
    output
  end
end

defmodule Benchmark do
  def run(input, keys) do
    Benchee.run(
      %{
        "map[key]" => fn ->
          for k <- keys, do: Benchmark.Map.AccessThruBracket.get(input, k)
        end,
        "Map.get/2" => fn ->
          for k <- keys, do: Benchmark.Map.MapGet.get(input, k)
        end,
        "Map.take/2" => fn ->
          for k <- keys, do: Benchmark.Map.MapTake.get(input, k)
        end,
        "Map.fetch/2" => fn ->
          for k <- keys, do: Benchmark.Map.MapFetch.get(input, k)
        end
      },
      time: 10,
      memory_time: 2
    )
  end
end

# 2) Prepare Input

require Logger
Logger.info("Generating massive amount of strings... (Can take a while)")
values = Enum.take(StreamData.string(:alphanumeric, max_length: 16), 500_000)

Logger.info("Put into a map.")
map = Enum.reduce(values, %{}, fn v, m -> Map.put(m, String.to_atom(v), v) end)

Logger.info("Figure out what keys to access later.")
keys_to_access = for {k, _} <- Enum.take_random(map, 1_000), into: [], do: k

Logger.info("Ready to benchmark.")

# 3) Run Benchmark

Benchmark.run(map, keys_to_access)
