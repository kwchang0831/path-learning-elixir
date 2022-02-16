###
# References:
#   https://hexdocs.pm/elixir/Map.html
###

# 1) Start ExUnit
ExUnit.start()

# 2) Create test module
defmodule AssertionTest do
  use ExUnit.Case, async: true

  defp input(), do: %{"zero" => 0, one: 1, two: 2}

  test "Create map" do
    assert Map.new() == %{}
    assert Map.new(one: 1, two: 2) == %{one: 1, two: 2}

    # key => value, key can be any type
    # key: value, is shorthand syntax which always transform key into atom
    assert %{:one => 1, :two => 2} == %{one: 1, two: 2}
    assert %{"one" => 1, "two" => 2} != %{one: 1, two: 2}

    # Mix different syntax, shorthand syntax must place at the end
    assert %{:one => 1, two: 2} == %{one: 1, two: 2}

    # No order
    assert %{"one" => :two, 3 => "four"} == %{3 => "four", "one" => :two}
    assert Map.equal?(%{"one" => :two, 3 => "four"}, %{3 => "four", "one" => :two})
  end

  test "Given key, Access value from a map" do
    # Ways to get value with given key
    assert input()["zero"] == 0
    assert input().one == 1
    assert input()[:one] == 1
    assert Map.get(input(), :one) == 1

    %{one: value} = Map.take(input(), [:one])
    assert value == 1

    # Pattern matching
    assert {:ok, 1} = Map.fetch(input(), :one)

    {:ok, output} = Map.fetch(input(), "zero")
    assert output == 0

    %{two: output} = input()
    assert output == 2
  end

  test "Given key, Access non-existent value from a map" do
    assert input()[:four] == nil
    assert_raise KeyError, fn -> input().four == nil end

    assert Map.get(input(), :four) == nil

    assert :error = Map.fetch(input(), :four)
    assert_raise KeyError, fn -> Map.fetch!(input(), :four) end

    # Set default value instead of nil
    assert Map.get(input(), :four, 0) == 0
  end

  test "Given keys, Access values from a map" do
    assert %{one: 1, two: 2} = Map.take(input(), [:one, :two])
    # Non-existent key
    assert %{} = Map.take(input(), [:four, :five])
  end

  test "Update value from a map" do
    assert %{input() | "zero" => "zero"} == %{"zero" => "zero", one: 1, two: 2}
    assert Map.replace(input(), :one, "one") == %{"zero" => 0, one: "one", two: 2}

    # Replace non-existent key
    assert Map.replace(input(), :four, 4) == input()

    # Update value if key exists otherwise add key/value
    assert Map.put(input(), :one, "one") == %{"zero" => 0, one: "one", two: 2}

    # Get old value and Update to new value, returns {get value, updated map}
    {old_value, new_map} =
      Map.get_and_update(input(), :one, fn current_value -> {current_value, "one"} end)

    assert old_value == 1
    assert new_map == %{"zero" => 0, one: "one", two: 2}

    # Update with non-existent key
    assert Map.replace(input(), :four, 4) == %{"zero" => 0, one: 1, two: 2}
    assert_raise KeyError, fn -> %{input() | four: 4} end
  end

  test "Add key/value into a map" do
    assert Map.put(input(), :four, 4) == %{"zero" => 0, one: 1, two: 2, four: 4}
    # Update value if key already exists otherwise add key/value
    assert Map.put(input(), :one, "one") == %{"zero" => 0, one: "one", two: 2}

    # Making sure only add value does not update value already exists
    assert Map.put_new(input(), :one, "one") != %{"zero" => 0, one: "one", two: 2, four: 4}
    assert Map.put_new(input(), :four, 4) == %{"zero" => 0, one: 1, two: 2, four: 4}

    # Add new key/value
    {old_value, new_map} =
      Map.get_and_update(input(), :four, fn current_value -> {current_value, 4} end)

    assert old_value == nil
    assert new_map == %{"zero" => 0, one: 1, two: 2, four: 4}
  end

  test "Merge two maps into one map" do
    assert Map.merge(input(), %{three: 3, four: 4}) == %{
             "zero" => 0,
             one: 1,
             two: 2,
             three: 3,
             four: 4
           }

    # Can also used to update existed values
    assert Map.merge(input(), %{one: "one", two: "two"}) == %{"zero" => 0, one: "one", two: "two"}

    # Resolve conflicts with function that concat two values into a string
    assert Map.merge(input(), %{one: "one", two: "two"}, fn _key, v1, v2 -> "#{v1}=#{v2}" end) ==
             %{"zero" => 0, one: "1=one", two: "2=two"}
  end

  test "Remove key(s) into a map" do
    assert Map.delete(input(), "zero") == %{one: 1, two: 2}
    # Remove non-existent key does not have effect
    assert Map.delete(input(), :four) == %{"zero" => 0, one: 1, two: 2}

    # Remove multiple keys
    assert Map.drop(input(), [:one, :two]) == %{"zero" => 0}

    {value, new_map} = Map.pop(input(), "zero")
    assert value == 0
    assert new_map == %{one: 1, two: 2}

    # Remove non-existent key does not have effect
    {value, new_map} = Map.pop(input(), :four)
    assert value == nil
    assert new_map == input()

    assert_raise KeyError, fn -> Map.pop!(input(), :four) end
  end

  test "Gets all the keys in the map" do
    # Sort both then compare
    assert Map.keys(input()) |> Enum.sort() == ["zero", :one, :two] |> Enum.sort()
  end

  test "Gets all the values in the map" do
    # Sort both then compare
    assert Map.values(input()) |> Enum.sort() == [0, 1, 2] |> Enum.sort()
  end
end
