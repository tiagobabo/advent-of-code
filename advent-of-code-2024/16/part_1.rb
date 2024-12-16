map = {}
start_position, end_position = nil, nil
directions_with_cost = {
  [1, 0] => { [1, 0] => 1, [-1, 0] => 2001, [0, 1] => 1001, [0, -1] => 1001 },
  [-1, 0] => { [1, 0] => 2001, [-1, 0] => 1, [0, 1] => 1001, [0, -1] => 1001 },
  [0, 1] => { [1, 0] => 1001, [-1, 0] => 1001, [0, 1] => 1, [0, -1] => 2001 },
  [0, -1] => { [1, 0] => 1001, [-1, 0] => 1001, [0, 1] => 2001, [0, -1] => 1 }
}

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.split('').each_with_index do |char, x|
    map[[x, y]] = char
    start_position = [x, y] if char == 'S'
    start_position = [x, y] if char == 'E'
  end
end

queue = [[start_position, [1, 0], 0]]
visited = {}

until queue.empty?
  position, direction, cost = queue.shift

  visited[[position, direction]] = cost

  next if map[position] == 'E'

  directions_with_cost[direction].each do |new_direction, new_cost|
    new_position = [position[0] + new_direction[0], position[1] + new_direction[1]]

    next if map[new_position] == '#'
    next if visited[[new_position, new_direction]] && visited[[new_position, new_direction]] <= (cost + new_cost)

    queue.append([new_position, new_direction, cost + new_cost])
  end
end

p visited.select { |(position, _), _| map[position] == 'E' }.values.min
