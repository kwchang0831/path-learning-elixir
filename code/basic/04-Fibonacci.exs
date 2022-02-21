###
# References:
#   https://r-knott.surrey.ac.uk/Fibonacci/fibFormula.html
###

# 1) Nth Fibonacci functions

# Straight forward
defmodule Fib_Naive do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 2) + fib(n - 1)
end

# Accumulate n-1 & n-2 in param with TCO (Tail Call Optimization)
defmodule Fib_Accumulator do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: _fib(n - 2, {1, 0})

  defp _fib(0, {f1, f2}), do: f1 + f2
  defp _fib(count, {f1, f2}), do: _fib(count - 1, {f1 + f2, f1})
end

defmodule Fib_Cached do
  def fib(n, cache \\ %{1 => 1, 0 => 0}) do
    case Map.get(cache, n) do
      nil ->
        {f1, cache} = fib(n - 1, cache)
        result = f1 + Map.get(cache, n - 2)
        {result, Map.put(cache, n, result)}

      cached_ans ->
        {cached_ans, cache}
    end
  end
end

defmodule Fib_Stream do
  def fib(n), do: Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1 + f2}} end) |> Enum.at(n)
end

# F_n = {[(√5 + 1)/2] ^ n} / √5
defmodule Fib_BinetFormula do
  def fib(n) do
    sqrt_five = :math.sqrt(5)
    (:math.pow((1 + sqrt_five) / 2, n) / sqrt_five) |> round
  end
end

# 2) Start ExUnit

ExUnit.start()

# 3) Create test module

defmodule AssertionTest_04Fibonacci do
  use ExUnit.Case, async: true

  test "Validate Fibonacci functions" do
    [n | _] = StreamData.integer(1..20) |> Enum.take(1)
    result = Fib_Naive.fib(n)

    assert result == Fib_Stream.fib(n)
    assert result == Fib_Accumulator.fib(n)
    assert result == Fib_BinetFormula.fib(n)
    assert {^result, _} = Fib_Cached.fib(n)
  end
end

# 4) Benchmark

defmodule Benchmark do
  def run() do
    Benchee.run(
      %{
        "Fib_Naive" => fn inputs ->
          for n <- inputs do
            Fib_Naive.fib(n)
          end
        end,
        "Fib_Stream" => fn inputs ->
          for n <- inputs do
            Fib_Stream.fib(n)
          end
        end,
        "Fib_Accumulator" => fn inputs ->
          for n <- inputs do
            Fib_Accumulator.fib(n)
          end
        end,
        "Fib_BinetFormula" => fn inputs ->
          for n <- inputs do
            Fib_BinetFormula.fib(n)
          end
        end,
        "Fib_Cached" => fn inputs ->
          Enum.reduce(inputs, %{1 => 1, 0 => 0}, fn n, cache ->
            Fib_Cached.fib(n, cache) |> elem(1)
          end)
        end
      },
      time: 10,
      memory_time: 2,
      inputs: %{
        "n=10..25(take 5)" => StreamData.integer(10..25) |> Enum.take(5),
        "n=10..25(take 25)" => StreamData.integer(10..25) |> Enum.take(25)
      },
      print: [fast_warning: false]
    )
  end
end

Benchmark.run()
