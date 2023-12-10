map = File.readlines('input.txt', chomp: true).map { |line| line.split('') }
s = map.each_with_index.map { |row, i| [i, row.index('S')] }.reject { |row| row[1].nil? }.first

points = [s]
points << [s[0] - 1, s[1]] if %w(| F 7).include?(map[s[0] - 1][s[1]])
points << [s[0] + 1, s[1]] if %w(| L J).include?(map[s[0] + 1][s[1]])
points << [s[0], s[1] - 1] if %w(- F L).include?(map[s[0]][s[1] - 1])
points << [s[0], s[1] + 1] if %w(- J 7).include?(map[s[0]][s[1] + 1])

map[s[0]][s[1]] = 'J' # replace S with direction

points = points.first(2)

until points.last == s
  previous, current = points.last(2)

  case map[current[0]][current[1]]
  when '|'
    previous[0] > current[0] ? points << [current[0] - 1, current[1]] : points << [current[0] + 1, current[1]]
  when '-'
    previous[1] > current[1] ? points << [current[0], current[1] - 1] : points << [current[0], current[1] + 1]
  when 'L'
    previous[0] == current[0] ? points << [current[0] - 1, current[1]] : points << [current[0], current[1] + 1]
  when 'J'
    previous[0] == current[0] ? points << [current[0] - 1, current[1]] : points << [current[0], current[1] - 1]
  when '7'
    previous[0] == current[0] ? points << [current[0] + 1, current[1]] : points << [current[0], current[1] - 1]
  when 'F'
    previous[0] == current[0] ? points << [current[0] + 1, current[1]] : points << [current[0], current[1] + 1]
  end
end

# Shoelace formula
vertices = points.uniq.select { |x, y| %w(F 7 L J).include?(map[x][y]) }
vertices << vertices.first
shoelaces = vertices.each_cons(2).map do |(x1, y1), (x2, y2)|
  x1 * y2 - x2 * y1
end

# Pick's theorem
area = (shoelaces.reduce(:+) / 2).abs
points_inside = (points.uniq.size / 2 - 1 - area).abs

p points_inside

# Alternative solution using Point in polygon
count = points.uniq.sort.group_by { |p| p.first }.each.inject(0) do |acc, (row, values)|
  values = values.map(&:last)
  counter = 0

  (values.first + 1..values.last - 1).each do |i|
    next if values.include?(i)

    counter += 1 if values.select { |w| w > i && %w(| J L).include?(map[row][w]) }.size.odd?
  end

  acc + counter
end

p count
