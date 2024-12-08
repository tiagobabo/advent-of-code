antennas = {}
antinodes = Set.new
max_x, max_y = 0, 0

def out_of_bounds?(y, x, max_y, max_x)
  y.negative? || x.negative? || y >= max_y || x >= max_x
end

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  max_y, max_x = y + 1, line.length

  line.split('').each_with_index do |char, x|
    next if char == '.'

    antennas[char] ||= []
    antennas[char] << [y, x]
  end
end

antennas.each do |_, coords|
  coords.combination(2).each do |(y1, x1), (y2, x2)|
    distance_delta_y, distance_delta_x = y2 - y1, x2 - x1

    new_antinode1 = [y1 + distance_delta_y * -1, x1 + distance_delta_x * -1]
    new_antinode2 = [y2 + distance_delta_y, x2 + distance_delta_x]

    antinodes << new_antinode1 unless out_of_bounds?(*new_antinode1, max_y, max_x)
    antinodes << new_antinode2 unless out_of_bounds?(*new_antinode2, max_y, max_x)
  end
end

p antinodes.length
