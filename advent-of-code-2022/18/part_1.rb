positions = Hash.new { [] }
cubes = {}

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  x, y, z = line.split(',').map(&:to_i)
  adjecent_cubes = Hash.new(0)
  cubes[i] = 6

  [
    [x, y, z],
    [x, y + 1, z],
    [x, y + 1, z + 1],
    [x , y, z + 1],
    [x + 1, y + 1, z + 1],
    [x + 1, y + 1, z],
    [x + 1, y, z],
    [x + 1, y, z + 1]
  ].each do |pos|
    positions[pos].each { |i| adjecent_cubes[i] += 1 }

    positions[pos] += [i]
  end

  adjecent_cubes.each do |i2, count|
    next if count < 3

    cubes[i2] -= 1
    cubes[i] -= 1
  end
end

p cubes.values.sum
