directions = {
  'D' => [1, 0],
  'U' => [-1, 0],
  'L' => [0, -1],
  'R' => [0, 1]
}

points_per_row = {}
current_point = [0, 0]

File.readlines('input.txt', chomp: true).each do |line|
  direction, amount, _ = line.split(' ')
  amount.to_i.times do
    current_point = current_point.zip(directions[direction]).map(&:sum)
    points_per_row[current_point[0]] ||= []
    points_per_row[current_point[0]] << current_point
  end
end

map = {}

points_per_row.each do |x, points|
  ys = points.map(&:last).sort
  min = ys.min
  max = ys.max
  (min..max).each do |y|
    map[[x, y]] = points.find { |point| point.last == y } ? '#' : '.'
  end
end

start_point = map.select { |_, value| value == '.' }.keys.first

queue = [start_point]

while queue.any?
  node = queue.shift

  next if map[node] == '#'

  map[node] = '#'

  queue << [node.first - 1, node.last] if map[[node.first - 1, node.last]] == '.'
  queue << [node.first + 1, node.last] if map[[node.first + 1, node.last]] == '.'
  queue << [node.first, node.last - 1] if map[[node.first, node.last - 1]] == '.'
  queue << [node.first, node.last + 1] if map[[node.first, node.last + 1]] == '.'
end

p map.values.count('#')
