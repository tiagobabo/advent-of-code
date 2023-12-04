def distance(c1, c2)
  (c1[0] - c2[0]).abs + (c1[1] - c2[1]).abs + (c1[2] - c2[2]).abs
end

cubes = File.readlines('input.txt', chomp: true).map { |line| line.split(',').map(&:to_i) }

max_x = cubes.map { |x, _, _| x }.max + 1
min_x = cubes.map { |x, _, _| x }.min - 1
max_y = cubes.map { |_, y, _| y }.max + 1
min_y = cubes.map { |_, y, _| y }.min - 1
max_z = cubes.map { |_, _, z| z }.max + 1
min_z = cubes.map { |_, _, z| z }.min - 1

internal_cubes = []

(min_x..max_x).each do |x|
  (min_y..max_y).each do |y|
    (min_z..max_z).each do |z|
      next if cubes.include?([x, y, z])

      internal_cubes << [x, y, z]
    end
  end
end

queue = [[min_x, min_y, min_z]]
seen = []

while queue.size > 0
  point = queue.shift

  next if cubes.include?(point) || seen.include?(point)

  seen << point

  internal_cubes.delete(point)

  x, y, z = point

  if x - 1 >= min_x
    queue << [x - 1, y, z]
  end

  if x + 1 <= max_x
    queue << [x + 1, y, z]
  end

  if y - 1 >= min_y
    queue << [x, y - 1, z]
  end

  if y + 1 <= max_y
    queue << [x, y + 1, z]
  end

  if z - 1 >= min_z
    queue << [x, y, z - 1]
  end

  if z + 1 <= max_z
    queue << [x, y, z + 1]
  end
end

result = cubes.size * 6
cubes.combination(2).each do |c1, c2|
  if distance(c1, c2) == 1
    result -= 2
  end
end

cubes.each do |cube|
  internal_cubes.each do |trapped_cube|
    if distance(cube, trapped_cube) == 1
      result -= 1
    end
  end
end

p result
