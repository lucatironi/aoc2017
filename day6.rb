require "minitest/autorun"

INPUT = "4  1 15  12  0 9 9 5 5 8 7 3 14  5 12  3"

class Memory
  attr_reader :banks, :log, :loops_before_seen

  def initialize(input)
    @banks = input.split(/\s+/).map(&:to_i)
    @log = [@banks]
    @loops_before_seen = 0
  end

  def cycle
    count = 0
    seen = true
    while seen do
      @banks = distribute
      count += 1
      if @log.include?(@banks)
        @loops_before_seen = @log.size - @log.index(@banks)
        seen = false
      else
        @log << @banks
      end
    end
    count
  end

  def distribute
    new_banks = banks.dup
    max = new_banks.max
    idx = new_banks.index(max)
    new_banks[idx] = 0
    while max > 0 do
      idx += 1
      new_banks[idx % new_banks.size] += 1
      max -= 1
    end
    new_banks
  end
end

class TestDay6 < Minitest::Test
  def test_input_cleaning
    memory = Memory.new("0 2 7 0")
    assert_equal [0, 2, 7, 0], memory.banks
  end

  def test_initial_log
    memory = Memory.new("0 2 7 0")
    assert_equal [[0, 2, 7, 0]], memory.log
  end

  def test_distribute
    memory = Memory.new("0 2 7 0")
    assert_equal [2, 4, 1, 2], memory.distribute
  end

  def test_cycle
    memory = Memory.new("0 2 7 0")
    out = memory.cycle
    assert_equal 5, out
    assert_equal [2, 4, 1, 2], memory.banks
    assert_equal [[0, 2, 7, 0], [2, 4, 1, 2], [3, 1, 2, 3], [0, 2, 3, 4], [1, 3, 4, 1]], memory.log
    assert_equal 4, memory.loops_before_seen
  end

  def test_final
    memory = Memory.new(INPUT)
    out = memory.cycle
    assert_equal 6681, out
    assert_equal 4, memory.loops_before_seen
  end
end
