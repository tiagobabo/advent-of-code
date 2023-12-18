require 'pqueue'

map = File.readlines('input.txt', chomp: true).map do |line, i|
  line.split('').map(&:to_i)
end

max_x = map.size - 1
max_y = map.first.size - 1

nodes_to_explore = PQueue.new([[0, 0, 0, nil, nil]]) { |a, b| a.first < b.first }
visited = {}

while nodes_to_explore.size > 0
  distance, x, y, direction, direction_count = nodes_to_explore.pop

  key = [x, y, direction, direction_count]

  next if visited[key]

  visited[key] = distance

  [[:up, [-1, 0]], [:down, [1, 0]], [:left, [0, -1]], [:right, [0, 1]]].each do |d, (dx, dy)|
    new_direction = d
    new_direction_count = new_direction == direction ? direction_count + 1 : 1

    new_x = x + dx
    new_y = y + dy
    reverse_direction = { up: :down, down: :up, left: :right, right: :left }[new_direction]
    max_direction_not_reached = new_direction_count <= 10
    going_same_direction = new_direction == direction
    min_direction_to_turn = direction_count.nil? ? true : direction_count >= 4

    if max_direction_not_reached && (going_same_direction || min_direction_to_turn) && (0..max_x).include?(new_x) && (0..max_y).include?(new_y) && direction != reverse_direction
      new_distance = distance + map[new_x][new_y]

      nodes_to_explore.push([new_distance, new_x, new_y, new_direction, new_direction_count])
    end
  end
end

p visited.select { |(x, y, _, _), _| x == max_x && max_y == y }.values.min
