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

#### **00-Hello-Spawn.exs**

Example Output (PIDs might be different)

```shell
#PID<0.93.0> | Started Hello_Spawner Server 1: #PID<0.200.0>
#PID<0.93.0> | Started Hello_Spawner Server 2: #PID<0.201.0>
#PID<0.200.0> | Got Msg from #PID<0.93.0>: Hello kwchang0831
#PID<0.201.0> | Got Msg from #PID<0.93.0>: Hello kwchang0831
```
