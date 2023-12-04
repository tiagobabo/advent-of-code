initial_position = [500, 0]
map = {}

File.readlines('input.txt', chomp: true).each do |line|
  line.split(' -> ').map { |p| p.split(',').map(&:to_i) }.each_cons(2) do |(p1_x, p1_y), (p2_x, p2_y)|
    x_range = p1_x > p2_x ? (p2_x..p1_x) : (p1_x..p2_x)
    y_range = p1_y > p2_y ? (p2_y..p1_y) : (p1_y..p2_y)
    x_range.each { |x| y_range.each { |y| map[[x, y]] = '#' } }
  end
end

units = 0
current_path = [initial_position]
max_y = map.keys.map(&:last).max

while current_path.size > 0
  x, y = current_path.last

  break if y == max_y

  new_y = y + 1

  if map[[x, new_y]].nil?
    current_path << [x, new_y]
  elsif map[[x - 1, new_y]].nil?
    current_path << [x - 1, new_y]
  elsif map[[x + 1, new_y]].nil?
    current_path << [x + 1, new_y]
  else
    current_path.pop
    map[[x, y]] = 'o'
    units += 1
  end
end

p units
