directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
rocks = Set.new
position = nil
direction = 0
max_x = 0
max_y = 0
visited = Set.new

File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  max_x = x + 1
  max_y = line.length
  line.split('').each_with_index do |char, y|
    position = [x, y] if char == '^'
    rocks << [x, y] if char == '#'
  end
end

visited << position

while true
  new_position = [position[0] + directions[direction][0], position[1] + directions[direction][1]]

  if rocks.include?(new_position)
    direction = (direction + 1) % 4
  elsif new_position[0] < 0 || new_position[0] >= max_x || new_position[1] < 0 || new_position[1] >= max_y
    break
  else
    position = new_position
    visited << position
  end
end

p visited.size
