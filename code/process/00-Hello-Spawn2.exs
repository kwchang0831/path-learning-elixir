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

  # Add TCO Looping
  def greet do
    receive do
      {caller, value} ->
        send(
          caller,
          {:ok, "#{inspect(self())} | Got Msg from #{inspect(caller)}: Hello #{value}"}
        )

        greet()
    end
  end
end

# 2) Client start Server by calling :start

pid = Hello_Spawner.start()
IO.puts("#{inspect(self())} | Started Hello_Spawner Server 1: #{inspect(pid)}")

# Send message to the Server
send(pid, {self(), "kwchang0831"})

receive do
  {:ok, message} ->
    IO.puts(message)
end

# Send message to the Server
send(pid, {self(), "this is another message"})

receive do
  {:ok, message} ->
    IO.puts(message)
end

# Timeout Example
receive do
  {:ok, message} ->
    IO.puts(message)
after
  1000 ->
    IO.puts("[INFO] We have not received any further messages.")
end
