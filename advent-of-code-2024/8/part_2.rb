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
    antinodes << [y, x]
  end
end

antennas.each do |_, coords|
  coords.combination(2).each do |(y1, x1), (y2, x2)|
    distance_delta_y, distance_delta_x = y2 - y1, x2 - x1

    (1..).each do |i|
      new_antinode = [y1 + (distance_delta_y * -1) * i, x1 + (distance_delta_x * -1) * i]

      break if out_of_bounds?(*new_antinode, max_y, max_x)

      antinodes << new_antinode
    end

    (1..).each do |i|
      new_antinode = [y2 + distance_delta_y * i, x2 + distance_delta_x * i]

      break if out_of_bounds?(*new_antinode, max_y, max_x)

      antinodes << new_antinode
    end
  end
end

p antinodes.length
