###
# Dependencies:
#   https://hexdocs.pm/stream_data/StreamData.html
#   https://hexdocs.pm/benchee/readme.html
###

# Benchmark different ways to Filter
# Filter out even numbers from a list containing all integers

# 1) Define different filter functions

defmodule Benchmark.List.Comprehension do
  def filter(list) do
    for num <- list, rem(num, 2) == 0, do: num
  end
end

defmodule Benchmark.List.EnumFilter do
  def filter(list) do
    list
    |> Enum.filter(&(rem(&1, 2) == 0))
  end
end

defmodule Benchmark.List.EnumFilterMap do
  def filter(list) do
    list
    |> Enum.filter(&(rem(&1, 2) == 0))
    |> Enum.map(& &1)
  end
end

defmodule Benchmark.List.StreamFilterMap do
  def filter(list) do
    list
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Enum.map(& &1)
  end
end

defmodule Benchmark.List.StreamFilterToList do
  def filter(list) do
    list
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Enum.to_list()
  end
end

defmodule Benchmark do
  def run() do
    Benchee.run(
      %{
        "for comprehension" => fn input ->
          Benchmark.List.Comprehension.filter(input)
        end,
        "Enum.filter/2" => fn input ->
          Benchmark.List.EnumFilter.filter(input)
        end,
        "Enum.filter/2 |> Enum.map/2" => fn input ->
          Benchmark.List.EnumFilterMap.filter(input)
        end,
        "Stream.filter/2 |> Enum.map/2" => fn input ->
          Benchmark.List.StreamFilterMap.filter(input)
        end,
        "Stream.filter/2 |> Enum.to_list/1" => fn input ->
          Benchmark.List.StreamFilterToList.filter(input)
        end
      },
      time: 10,
      memory_time: 2,
      inputs: %{
        "Million Integers" => Enum.take(StreamData.integer(), 1_000_000)
      }
    )
  end
end

# 2) Run Benchmark

Benchmark.run()
