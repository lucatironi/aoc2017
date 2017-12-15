require "minitest/autorun"

CONSTANT = 2147483647

class Generator
  attr_reader :value, :factor, :div

  def initialize(value, factor, div = 1)
    @value = value
    @factor = factor
    @div = div
  end

  def next_value
    loop do
      @value = (@value * @factor) % CONSTANT
      break if @value % @div < 1
    end
  end
end

class TestDay15 < Minitest::Test
  def test_init
    a = Generator.new(65, 16807)
    assert_equal 65, a.value
    assert_equal 16807, a.factor
    assert_equal 1, a.div
  end

  def test_part1
    a = Generator.new(65, 16807)
    b = Generator.new(8921, 48271)

    a.next_value
    assert_equal 1092455, a.value
    a.next_value
    assert_equal 1181022009, a.value
    a.next_value
    assert_equal 245556042, a.value
    a.next_value
    assert_equal 1744312007, a.value
    a.next_value
    assert_equal 1352636452, a.value

    b.next_value
    assert_equal 430625591, b.value
    b.next_value
    assert_equal 1233683848, b.value
    b.next_value
    assert_equal 1431495498, b.value
    b.next_value
    assert_equal 137874439, b.value
    b.next_value
    assert_equal 285222916, b.value
  end

  def test_part2
    a = Generator.new(65, 16807, 4)
    b = Generator.new(8921, 48271, 8)

    a.next_value
    assert_equal 1352636452, a.value
    a.next_value
    assert_equal 1992081072, a.value
    a.next_value
    assert_equal 530830436, a.value
    a.next_value
    assert_equal 1980017072, a.value
    a.next_value
    assert_equal 740335192, a.value

    b.next_value
    assert_equal 1233683848, b.value
    b.next_value
    assert_equal 862516352, b.value
    b.next_value
    assert_equal 1159784568, b.value
    b.next_value
    assert_equal 1616057672, b.value
    b.next_value
    assert_equal 412269392, b.value
  end
end

# Part 1
a = Generator.new(699, 16807)
b = Generator.new(124, 48271)
c = 65535
judge_count = 0
40_000_000.times do
  a.next_value
  b.next_value
  judge_count += 1 if 0 == (a.value & c) ^ (b.value & c)
end

p judge_count

# Part 2
a = Generator.new(699, 16807, 4)
b = Generator.new(124, 48271, 8)
c = 65535
judge_count = 0
5_000_000.times do
  a.next_value
  b.next_value
  judge_count += 1 if 0 == (a.value & c) ^ (b.value & c)
end

p judge_count
