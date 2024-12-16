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

queue = [[start_position, [1, 0], 0, Set[start_position]]]
visited = {}
part_of_best_paths = {}

until queue.empty?
  position, direction, cost, previous = queue.shift

  visited[[position, direction]] = cost

  if map[position] == 'E'
    part_of_best_paths[cost] ||= Set.new
    part_of_best_paths[cost].merge(previous)
    next
  end

  directions_with_cost[direction].each do |new_direction, new_cost|
    new_position = [position[0] + new_direction[0], position[1] + new_direction[1]]

    next if map[new_position] == '#'
    next if visited[[new_position, new_direction]] && visited[[new_position, new_direction]] < (cost + new_cost)

    queue.append([new_position, new_direction, cost + new_cost, previous + [new_position]])
  end
end

p part_of_best_paths.min_by { |k, _| k }.last.size
