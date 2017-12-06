require "minitest/autorun"

def spiral(number)
  steps_to_center(number) + (inner_offset(number) - steps_to_center(number)).abs
end

def side_length(number)
  root = Math.sqrt(number).ceil
  root % 2 == 0 ? root + 1 : root
end

def steps_to_center(number)
  (side_length(number) - 1) / 2
end

def cycle(number)
  number - ((side_length(number) - 2) ** 2)
end

def inner_offset(number)
  cycle(number) % (side_length(number) - 1)
end

class TestDay3Part1 < Minitest::Test
  def test_side_length
    assert_equal 3, side_length(2)
    assert_equal 3, side_length(8)
    assert_equal 5, side_length(11)
    assert_equal 5, side_length(23)
    assert_equal 7, side_length(27)
  end

  def test_steps_to_center
    assert_equal 1, steps_to_center(2)
    assert_equal 1, steps_to_center(8)
    assert_equal 2, steps_to_center(11)
    assert_equal 2, steps_to_center(23)
    assert_equal 3, steps_to_center(27)
  end

  def test_cycle
    assert_equal 1, cycle(2)
    assert_equal 7, cycle(8)
    assert_equal 2, cycle(11)
    assert_equal 14, cycle(23)
    assert_equal 2, cycle(27)
  end

  def test_inner_offset
    assert_equal 1, inner_offset(2)
    assert_equal 1, inner_offset(8)
    assert_equal 2, inner_offset(11)
    assert_equal 2, inner_offset(23)
    assert_equal 2, inner_offset(27)
  end

  def test_trivial
    assert_equal 2, spiral(3)
  end

  def test_final
    assert_equal 552, spiral(325489)
  end
end

# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23  24  25
