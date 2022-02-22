# Basic

## Run

Get dependencies first

```shell
mix do deps.get
```

Run the specific exercise

```shell
mix run ./code/basic/00-HelloWorld.exs
```

## Contents

### Level 0

#### [**00-HelloWorld.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/00-HelloWorld.exs)

### Level 1

#### [**01-ExUnit.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/01-ExUnit.exs)

Get familiar with Elixir's unit testing feature.

### Level 2

#### [**02-List.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/02-List.exs)

#### [**02-List-Filter-Benchmark.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/02-List-Filter-Benchmark.exs)

Filter even numbers from a list of million integers

```shell
Comparison:
Name                                        ips 
for comprehension                         32.14
Enum.filter/2                             29.52 - 1.09x slower +2.76 ms
Enum.filter/2 |> Enum.map/2               21.66 - 1.48x slower +15.04 ms
Stream.filter/2 |> Enum.to_list/1         13.40 - 2.40x slower +43.49 ms
Stream.filter/2 |> Enum.map/2             12.73 - 2.52x slower +47.42 ms
```

#### [**02-Map.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/02-Map.exs)

#### [**02-Map-Access-Benchmark.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/02-Map-Access-Benchmark.exs)

Access random 1_000 keys from a map contains half a million keys

```shell
Comparison:
Name                  ips 
Map.get/2          9.38 K
map[key]           8.37 K - 1.12x slower +12.85 μs
Map.fetch/2        7.49 K - 1.25x slower +26.90 μs
Map.take/2         5.11 K - 1.83x slower +88.92 μs
```

### Level 3

#### [**03-File-IO.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/03-File-IO.exs)

### Level 4

#### [**04-Fibonacci.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/basic/04-Fibonacci.exs)

```shell
##### With input n=10..25(take 5) #####
Comparison:
Name                       ips 
Fib_BinetFormula        1.85 M
Fib_Accumulator2        1.48 M - 1.25x slower +0.134 μs
Fib_Accumulator         1.19 M - 1.55x slower +0.30 μs
Fib_Cached              0.40 M - 4.67x slower +1.99 μs
Fib_Stream             0.124 M - 14.93x slower +7.55 μs
Fib_Naive            0.00948 M - 194.60x slower +104.92 μs

Name                Memory usage
Fib_BinetFormula         0.36 KB
Fib_Accumulator2         0.20 KB - 0.57x memory usage -0.15625 KB
Fib_Accumulator          1.77 KB - 4.93x memory usage +1.41 KB
Fib_Cached               4.38 KB - 12.20x memory usage +4.02 KB
Fib_Stream               9.78 KB - 27.22x memory usage +9.42 KB
Fib_Naive                0.20 KB - 0.57x memory usage -0.15625 KB

##### With input n=10..25(take 25) #####
Comparison:
Name                       ips 
Fib_BinetFormula      407.58 K
Fib_Accumulator2      284.14 K - 1.43x slower +1.07 μs
Fib_Cached            235.16 K - 1.73x slower +1.80 μs
Fib_Accumulator       178.59 K - 2.28x slower +3.15 μs
Fib_Stream             39.06 K - 10.44x slower +23.15 μs
Fib_Naive               0.37 K - 1115.52x slower +2734.48 μs

Name                Memory usage
Fib_BinetFormula         1.61 KB
Fib_Accumulator2         0.83 KB - 0.51x memory usage -0.78125 KB
Fib_Cached               7.38 KB - 4.59x memory usage +5.77 KB
Fib_Accumulator          9.69 KB - 6.02x memory usage +8.08 KB
Fib_Stream              53.09 KB - 32.99x memory usage +51.48 KB
Fib_Naive                0.83 KB - 0.51x memory usage -0.78125 KB
```
