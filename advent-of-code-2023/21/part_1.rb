directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
map = {}
starting_position = nil
File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  line.split('').each_with_index do |char, y|
    if char == 'S'
      starting_position = [x, y]
      char = '.'
    end

    map[[x, y]] = char
  end
end

queue = [[starting_position, 0]]
visited = {}

while true
  (x, y), step = queue.shift

  key = [[x, y], step]

  next if visited[key]

  visited[key] = true

  if step == 64
    queue << key
    break
  end

  directions.each do |dx, dy|
    new_x = x + dx
    new_y = y + dy

    if map[[new_x, new_y]] == '.'
      key = [[new_x, new_y], step + 1]
      queue << key
    end
  end
end

p queue.uniq.size
