max_steps = 1024
max_x, max_y = 70, 70
obstacles = {}

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  break if i == max_steps

  x, y = line.split(',').map(&:to_i)
  obstacles[[x, y]] = '#'
end

start_position = [0, 0]
end_position = [max_x, max_y]

queue = [[start_position, 0]]
visited = Set.new

until queue.empty?
  current_position, steps = queue.shift

  next if visited.include?(current_position)

  visited << current_position

  if current_position == end_position
    puts steps
    break
  end

  x, y = current_position
  [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |new_position|
    if new_position[0] >= 0 && new_position[0] <= max_x && new_position[1] >= 0 && new_position[1] <= max_y && !obstacles.include?(new_position)
      queue << [new_position, steps + 1]
    end
  end
end
