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
Map.get/2          9.38 K
map[key]           8.37 K - 1.12x slower +12.85 μs
Map.fetch/2        7.49 K - 1.25x slower +26.90 μs
Map.take/2         5.11 K - 1.83x slower +88.92 μs
```

### Level 3

#### **03-File-IO.exs**
