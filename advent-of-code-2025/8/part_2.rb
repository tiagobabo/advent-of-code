points = {}

def distance(p1, p2)
  Math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2 + (p1[2] - p2[2])**2)
end

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  points[line.split(',').map(&:to_i)] = i
end

points.keys.combination(2).sort_by { |p1, p2| distance(p1, p2) }.each do |(x1, y1, z1), (x2, y2, z2)|
  next if points[[x1, y1, z1]] == points[[x2, y2, z2]]

  points.select { |_, v| v == points[[x1, y1, z1]] }.each do |(x, y, z), _|
    points[[x, y, z]] = points[[x2, y2, z2]]
  end

  if points.values.uniq.size == 1
    p x1 * x2
    break
  end
end
