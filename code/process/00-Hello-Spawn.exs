###
# References:
#   https://hexdocs.pm/elixir/Process.html
#   https://hexdocs.pm/elixir/Kernel.html#spawn/1
###

# 1) Sever Impl
defmodule Hello_Spawner do
  def start do
    spawn(&greet/0)
  end

  def greet do
    receive do
      {caller, value} ->
        IO.puts("#{inspect(self())} | Got Msg from #{inspect(caller)}: Hello #{value}")
    end
  end
end

# 2) Client start Server by calling :start
pid = Hello_Spawner.start()
IO.puts("#{inspect(self())} | Started Hello_Spawner Server 1: #{inspect(pid)}")

# Send message to the Server
send(pid, {self(), "kwchang0831"})

# 3) Client start Server by calling spawn
pid = spawn(Hello_Spawner, :greet, [])
IO.puts("#{inspect(self())} | Started Hello_Spawner Server 2: #{inspect(pid)}")

# Send message to the Server
send(pid, {self(), "kwchang0831"})
