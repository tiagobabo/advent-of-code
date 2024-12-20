map = {}
start_position, end_position = nil, nil

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.split('').each_with_index do |char, x|
    map[[x, y]] = char
    start_position = [x, y] if char == 'S'
    end_position = [x, y] if char == 'E'
  end
end

queue = [[start_position, 0]]
visited = Set.new
distance_cache = {}

until queue.empty?
  position, steps = queue.shift
  x, y = position

  visited << position

  if position == end_position
    distance_cache[position] = steps
    break
  end

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dx, dy|
    new_position = [x + dx, y + dy]

    next unless map[new_position] == '.'
    next if visited.include?(new_position)

    distance_cache[[x, y]] = steps

    queue << [new_position, steps + 1]
  end
end

total = 0

distance_cache.keys.permutation(2).each do |(x1, y1), (x2, y2)|
  cheat_distance = (x1 - x2).abs + (y1 - y2).abs

  next if cheat_distance > 20
  next if distance_cache[[x2, y2]] - (distance_cache[[x1, y1]] + cheat_distance) < 100

  total += 1
end

p total
