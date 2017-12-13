require "minitest/autorun"

class Firewall
  attr_reader :depths, :layers

  def initialize(input)
    a = []
    input.each_line do |line|
      idx, depth = line.split(": ")
      a[idx.to_i] = depth.to_i
    end

    @depths = a.map(&:to_i)
  end

  def severity(delay = 0)
    @depths.each_with_index.reduce(0) do |sev, (depth, idx)|
      idx += delay
      sev += idx * depth if (idx % ((depth - 1) * 2)).zero?
      sev
    end
  end
end

class TestDay13 < Minitest::Test
  def test_init
    firewall = Firewall.new(TRIVIAL_INPUT)
    assert_equal [3, 2, 0, 0, 4, 0, 4], firewall.depths
  end

  def test_severity
    firewall = Firewall.new(TRIVIAL_INPUT)

    assert_equal 24, firewall.severity
  end
end

TRIVIAL_INPUT = <<-TXT
0: 3
1: 2
4: 4
6: 4
TXT

INPUT = <<-TXT
0: 4
1: 2
2: 3
4: 4
6: 6
8: 5
10: 6
12: 6
14: 6
16: 8
18: 8
20: 9
22: 12
24: 8
26: 8
28: 8
30: 12
32: 12
34: 8
36: 12
38: 10
40: 12
42: 12
44: 10
46: 12
48: 14
50: 12
52: 14
54: 14
56: 12
58: 14
60: 12
62: 14
64: 18
66: 14
68: 14
72: 14
76: 14
82: 14
86: 14
88: 18
90: 14
92: 17
TXT


firewall = Firewall.new(INPUT)

# Part 1
p firewall.severity

# Part 2 BRUTE FORCE!!! Sorry...
delay = 0
while 1 do
  sev = firewall.severity(delay)
  break if sev.zero?
  delay += 1
end

p delay
