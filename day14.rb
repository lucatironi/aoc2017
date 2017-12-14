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

  def twist(lengths)
    lengths.each { |i| tie(i) }
  end

  def hash(input)
    lengths = input.bytes + [17, 31, 73, 47, 23]
    64.times { twist(lengths) }

    res = list.each_slice(16).map do |byte|
      byte.reduce(0, :^).to_s(16).rjust(2, ?0)
    end

    res.join
  end
end

input = "oundnydw"

regions = 0
used_squares = 0
@disk = []

0.upto(127) do |i|
  s = "#{input}-#{i}"
  h = KnotHash.new.hash(s)
  b = h.hex.to_s(2).rjust(h.size * 4, ?0).chars.map(&:to_i)
  used_squares += b.sum # Part 1
  @disk[i] = b
end

# Part 1
p used_squares

# Part 2
@visited = Array.new(128) { Array.new(128, false) }

def dfs(i, j)
  return if @visited[i][j] || @disk[i][j].zero?
  @visited[i][j] = true

  dfs(i - 1, j) if i > 0
  dfs(i + 1, j) if i < 127
  dfs(i, j - 1) if j > 0
  dfs(i, j + 1) if j < 127
end

0.upto(127) do |i|
  0.upto(127) do |j|
    next if @visited[i][j] || @disk[i][j].zero?
    regions += 1
    dfs(i, j)
  end
end

p regions
