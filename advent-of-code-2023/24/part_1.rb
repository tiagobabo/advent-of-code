points = {}

File.readlines('input.txt', chomp: true).each do |line|
  point, velocities = line.split(' @ ')
  x, y, _ = point.split(', ')
  x_velocity, y_velocity = velocities.split(', ')
  points[[x.to_r, y.to_r]] = [x_velocity.to_r, y_velocity.to_r]
end

def calculate_function_m(x1, y1, x2, y2)
  (y2 - y1) / (x2 - x1)
end

def calculate_function_b(x1, y1, m)
  y1 - (m * x1)
end

def functions_intersect_x(m1, b1, m2, b2)
  (b2 - b1) / (m1 - m2)
rescue ZeroDivisionError
  Float::INFINITY
end

def get_y(m, b, x)
  (m * x) + b
end

def future?(x1, x2, velocity_x)
  if velocity_x > 0
    x1 <= x2
  else
    x1 >= x2
  end
end

intersect = 0
# min_point = 7
# max_point = 27
min_point = 200000000000000
max_point = 400000000000000

points.keys.combination(2).each do |point_1, point_2|
  x1, y1 = point_1
  x2, y2 = point_1[0] + points[point_1][0], point_1[1] + points[point_1][1]

  m = calculate_function_m(x1, y1, x2, y2)
  b = calculate_function_b(x1, y1, m)

  x1, y1 = point_2
  x2, y2 = point_2[0] + points[point_2][0], point_2[1] + points[point_2][1]

  m2 = calculate_function_m(x1, y1, x2, y2)
  b2 = calculate_function_b(x1, y1, m2)

  x_intersect = functions_intersect_x(m, b, m2, b2)

  next if x_intersect.infinite?

  y_intersect_1 = get_y(m, b, x_intersect)
  y_intersect_2 = get_y(m2, b2, x_intersect)

  if (min_point..max_point).include?(x_intersect.to_i) &&
    (min_point..max_point).include?(y_intersect_1.to_i) &&
    (min_point..max_point).include?(y_intersect_2.to_i) &&
    future?(point_1[0], x_intersect, points[point_1][0]) &&
    future?(point_2[0], x_intersect, points[point_2][0]) &&
    y_intersect_1 == y_intersect_2

    intersect += 1
  end
end

p intersect
