###
# References:
#   https://hexdocs.pm/ex_unit/ExUnit.Callbacks.html
#   https://hexdocs.pm/elixir/List.html
#   https://hexdocs.pm/elixir/List.html#functions
#   https://hexdocs.pm/elixir/Kernel.html#hd/1
#   https://hexdocs.pm/elixir/Kernel.html#tl/1
#   https://hexdocs.pm/elixir/Kernel.html#length/1
#   https://hexdocs.pm/elixir/Kernel.html#sigil_w/2
###

# 1) Start ExUnit
ExUnit.start()

# 2) Create test module
defmodule AssertionTest_02List do
  use ExUnit.Case, async: true

  setup do
    [
      # Words are represented using charlists
      list1: ['one', 'two', 'three'],
      list2: ['four', 'five']
    ]
  end

  test "Sigil words interpolated", context do
    # Words sigil with modifiers c for charlists
    expected_output = ~w(one two three)c

    assert context.list1 == expected_output
  end

  test "Extract first item in the list", context do
    [h | _] = context.list1
    expected_output = 'one'

    assert h == expected_output
    assert hd(context.list1) == expected_output
    assert List.first(context.list1) == expected_output
  end

  test "Extract last item in the list", context do
    assert List.last(context.list1) == 'three'
  end

  test "Extract items in the list besides first item", context do
    [_ | t] = context.list1
    expected_output = ~w(two three)c

    assert t == expected_output
    assert tl(context.list1) == expected_output
  end

  test "Concatenate two lists", context do
    assert context.list1 ++ context.list2 == ~w(one two three four five)c
  end

  test "Insert in the front of list", context do
    assert ['zero' | context.list1] == ~w(zero one two three)c
  end

  test "Length of the list", context do
    assert length(context.list1) == 3
  end

  test "Insert an item into the list at index", context do
    assert List.insert_at(context.list1, 2, 'insert') == ~w(one two insert three)c
  end

  test "Pop an item from the list at index", context do
    {pop_item, new_list} = List.pop_at(context.list1, 1)

    assert pop_item == 'two'
    assert new_list == ~w(one three)c

    {pop_item, new_list} = List.pop_at(context.list1, -2)
    assert pop_item == 'two'
    assert new_list == ~w(one three)c
  end

  test "List comprehension", context do
    # Filter out only words with 3 letters
    # For all words in list1 if length of the word is 3 return it
    new_list = for w <- context.list1, length(w) == 3, do: w
    assert new_list == ~w(one two)c
  end
end
