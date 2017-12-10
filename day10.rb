require "minitest/autorun"

class KnotHash
  attr_reader :list, :current_position, :skip_size

  def initialize(size = 256)
    @list = (0...size).to_a
    @current_position = 0
    @skip_size = 0
  end

  def tie(n)
    @list.rotate!(@current_position)
    @list[0, n] = @list[0, n].reverse
    @list.rotate!(-@current_position)
    @current_position += n + @skip_size
    @skip_size += 1
  end

  def twist(input)
    input.each { |i| tie(i) }
  end
end

class TestDay10 < Minitest::Test
  def test_tie
    hash = KnotHash.new(5)
    lengths = [3, 4, 1, 5]

    hash.tie(3)
    assert_equal [2, 1, 0, 3, 4], hash.list

    hash.tie(4)
    assert_equal [4, 3, 0, 1, 2], hash.list

    hash.tie(1)
    assert_equal [4, 3, 0, 1, 2], hash.list

    hash.tie(5)
    assert_equal [3, 4, 2, 1, 0], hash.list
  end

  def test_twist
    hash = KnotHash.new(5)
    lengths = [3, 4, 1, 5]

    hash.twist(lengths)
    assert_equal [3, 4, 2, 1, 0], hash.list
  end
end

input = "129,154,49,198,200,133,97,254,41,6,2,1,255,0,191,108"

# Part 1
hash = KnotHash.new
hash.twist(input.split(",").map(&:to_i))

p hash.list.take(2).reduce(&:*)

# Part 2
hash = KnotHash.new
lengths = input.bytes + [17, 31, 73, 47, 23]
64.times { hash.twist(lengths) }

res = hash.list.each_slice(16).map do |byte|
  byte.reduce(0, :^).to_s(16).rjust(2, ?0)
end

p res.join
