###
# References:
#   https://hexdocs.pm/ex_unit/ExUnit.html
#   https://hexdocs.pm/ex_unit/ExUnit.Assertions.html#functions
###

# 1) Start ExUnit
ExUnit.start()

# 2) Create test module
defmodule AssertionTest do
  use ExUnit.Case, async: true

  test "positive assertion" do
    assert true
  end

  test "negative assertion" do
    refute false
  end

  test "1 + 1 = 2" do
    assert 1 + 1 == 2
  end

  test "1 + 1 != 3" do
    refute 1 + 1 == 3
  end

  # 1/7 = 0.142857142857...
  test "1/7 shall less than 0.14286 " do
    assert 1 / 7 < 0.14286
  end

  test "1/7 != 0.14286" do
    refute 1 / 7 == 0.14286
  end

  test "positive assert with delta range" do
    # Actual Outputs, Expected Output, Delta Range
    assert_in_delta 1 / 7, 0.14286, 1.0e-5
  end

  test "negative assert with delta range" do
    refute_in_delta 1 / 7, 0.14286, 1.0e-9
  end
end
