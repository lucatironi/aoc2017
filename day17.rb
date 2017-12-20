# Part 1
buffer = [0]
current_index = 0
input = 314

(1..2017).each do |n|
  current_index = (current_index + input) % buffer.size
  buffer.insert(current_index + 1, n)
  current_index += 1
end

p buffer[buffer.index(2017) + 1]

# Part 2
v = nil
current_index = 0

(1..50_000_000).each do |n|
  current_index = (current_index + input) % n
  v = n if current_index == 0
  current_index += 1
end

p v
