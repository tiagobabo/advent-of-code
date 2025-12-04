map = {}
total_rolls = 0
directions = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.split('').each_with_index do |char, x|
    map[[x, y]] = char
  end
end

map.each do |(x, y), char|
  next unless char == '@'

  adjecent_rolls = 0

  directions.each do |(dx, dy)|
    new_x = x + dx
    new_y = y + dy

    adjecent_rolls += 1 if map[[new_x, new_y]] == '@'
  end

  total_rolls += 1 if adjecent_rolls < 4
end

p total_rolls
