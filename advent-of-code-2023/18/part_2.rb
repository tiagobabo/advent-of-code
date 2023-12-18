directions = {
  '1' => [1, 0],
  '3' => [-1, 0],
  '2' => [0, -1],
  '0' => [0, 1]
}

points = []
current_point = [0, 0]
total_points_in_path = 0

File.readlines('input.txt', chomp: true).each do |line|
  _, _, hex = line.split(' ')

  direction = hex[-2]
  times = hex[2..-3].to_i(16)

  current_point_x = current_point[0] + directions[direction][0] * times
  current_point_y = current_point[1] + directions[direction][1] * times

  # manhattan distance
  total_points_in_path += (current_point_x - current_point[0]).abs + (current_point_y - current_point[1]).abs

  current_point = [current_point_x, current_point_y]

  points << current_point
end

# shoelace formula
shoelaces = (points + [points.first]).each_cons(2).map do |(x1, y1), (x2, y2)|
  (x1 * y2) - (x2 * y1)
end

area = (shoelaces.reduce(:+) / 2).abs

# Pick's theorem
points_inside = (total_points_in_path / 2 - 1 - area).abs

p points_inside + total_points_in_path
