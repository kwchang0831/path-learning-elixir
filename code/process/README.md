# Process

## Run

Get dependencies first

```shell
mix do deps.get
```

Run the specific exercise

```shell
mix run ./code/process/00-Hello-Spawn.exs
```

## Contents

### Level 0

#### [**00-Hello-Spawn.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/process/00-Hello-Spawn.exs)

Example Output (PIDs might be different)

```shell
#PID<0.93.0> | Started Hello_Spawner Server 1: #PID<0.200.0>
#PID<0.93.0> | Started Hello_Spawner Server 2: #PID<0.201.0>
#PID<0.200.0> | Got Msg from #PID<0.93.0>: Hello kwchang0831
#PID<0.201.0> | Got Msg from #PID<0.93.0>: Hello kwchang0831
```

#### [**00-Hello-Spawn2.exs**](https://github.com/kwchang0831/path-learning-elixir/blob/main/code/process/00-Hello-Spawn2.exs)

Example Output (PIDs might be different)

```shell
#PID<0.93.0> | Started Hello_Spawner Server 1: #PID<0.200.0>
#PID<0.200.0> | Got Msg from #PID<0.93.0>: Hello kwchang0831
#PID<0.200.0> | Got Msg from #PID<0.93.0>: Hello this is another message
[INFO] We have not received any further messages.
```
