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

#### **00-HelloWorld.exs**

### Level 1

#### **01-ExUnit.exs**

Get familiar with Elixir's unit testing feature.

### Level 2

#### **02-List.exs**

#### **02-List-Filter-Benchmark.exs**

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

#### **02-Map.exs**

#### **02-Map-Access-Benchmark.exs**

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

#### **03-File-IO.exs**

### Level 4

#### **04-Fibonacci.exs**

```shell
##### With input n=10..25(take 5) #####
Comparison:
Name                       ips 
Fib_BinetFormula     1687.65 K
Fib_Accumulator      1081.76 K - 1.56x slower +0.33 μs
Fib_Cached            315.70 K - 5.35x slower +2.58 μs
Fib_Stream            144.89 K - 11.65x slower +6.31 μs
Fib_Naive               1.80 K - 940.15x slower +556.49 μs

Name                Memory usage
Fib_BinetFormula         0.36 KB
Fib_Accumulator          2.03 KB - 5.65x memory usage +1.67 KB
Fib_Cached               6.01 KB - 16.72x memory usage +5.65 KB
Fib_Stream              10.90 KB - 30.33x memory usage +10.54 KB
Fib_Naive                0.20 KB - 0.57x memory usage -0.15625 KB

##### With input n=10..25(take 25) #####
Comparison:
Name                       ips 
Fib_BinetFormula      376.40 K
Fib_Cached            229.92 K - 1.64x slower +1.69 μs
Fib_Accumulator       195.32 K - 1.93x slower +2.46 μs
Fib_Stream             37.41 K - 10.06x slower +24.08 μs
Fib_Naive               0.28 K - 1337.09x slower +3549.62 μs

Name                Memory usage
Fib_BinetFormula         1.61 KB
Fib_Cached               7.38 KB - 4.59x memory usage +5.77 KB
Fib_Accumulator          9.99 KB - 6.21x memory usage +8.38 KB
Fib_Stream              54.41 KB - 33.81x memory usage +52.80 KB
Fib_Naive                0.83 KB - 0.51x memory usage -0.78125 KB
```
