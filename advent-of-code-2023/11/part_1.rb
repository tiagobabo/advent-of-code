map = File.readlines('input.txt', chomp: true).map { |line| line.split('') }
positions = map.map.with_index { |row, i| row.map.with_index { |col, j| [i, j] if col == '#' } }.flatten(1).compact
original_positions = positions.dup

map.each_with_index do |row, i|
  next unless row.all? { |p| p == '.' }

  original_positions.each_with_index do |(x, y), j|
    positions[j] = [positions[j][0] + 1, positions[j][1]] if x > i
  end
end

map.transpose.each_with_index do |row, i|
  next unless row.all? { |p| p == '.' }

  original_positions.each_with_index do |(x, y), j|
    positions[j] = [positions[j][0], positions[j][1] + 1] if y > i
  end
end

result = positions.combination(2).reduce(0) do |acc, ((x1, y1), (x2, y2))|
  acc + (x1 - x2).abs + (y1 - y2).abs
end

p result
