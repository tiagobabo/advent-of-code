limit = 4_000_000
rows = Array.new(limit) { Array.new }

def overlaps?(range_1, range_2)
  range_1.cover?(range_2.first) || range_2.cover?(range_1.first)
end

def manhattan_distance(p1_x, p1_y, p2_x, p2_y)
  (p1_x - p2_x).abs + (p1_y - p2_y).abs
end

File.readlines('input.txt', chomp: true).each do |line|
  tokens = line.split(' ')
  sensor_x = tokens[2].split('=').last.to_i
  sensor_y = tokens[3].split('=').last[0..-1].to_i
  beacon_x = tokens[8].split('=').last[0..-1].to_i
  beacon_y = tokens[9].split('=').last.to_i

  distance = manhattan_distance(sensor_x, sensor_y, beacon_x, beacon_y)

  rows.each_with_index do |row, index|
    next if (index < sensor_y - distance) || (index > sensor_y + distance)

    range = [
      (distance - (sensor_y - index).abs - sensor_x) * -1,
      (distance - (sensor_y - index).abs + sensor_x)
    ]

    range_min = range.min
    range_max = range.max

    row_range = ([range_min, 0].max..[range_max, limit].min)

    next if row.any? { |range| range.cover?(row_range) }

    overlaps = row.select { |range| overlaps?(range, row_range) }

    unless overlaps.empty?
      min = [*overlaps.map(&:first), row_range.first].min
      max = [*overlaps.map(&:last), row_range.last].max
      row_range = (min..max)
      overlaps.each { |overlap| row.delete(overlap) }
    end

    row << row_range
  end
end

rows.each_with_index do |row, index|
  next if row.size == 1

  _, n2, _ = [
    row.first.first,
    row.first.last,
    row.last.first,
    row.last.last
  ].sort

  p n2.next * limit + index

  break
end
