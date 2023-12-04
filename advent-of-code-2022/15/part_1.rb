y = 2_000_000
no_beacons_ranges = []
beacons_in_y = {}

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

  next unless (sensor_y - distance..sensor_y + distance).include?(y)

  beacons_in_y[[beacon_x, beacon_y]] = true if beacon_y == y

  range = [
    (distance - (sensor_y - y).abs - sensor_x) * -1,
    (distance - (sensor_y - y).abs + sensor_x)
  ]
  row_range = (range.min..range.max)

  next if no_beacons_ranges.any? { |range| range.cover?(row_range) }

  overlaps = no_beacons_ranges.select { |range| overlaps?(range, row_range) }

  unless overlaps.empty?
    min = [*overlaps.map(&:first), row_range.first].min
    max = [*overlaps.map(&:last), row_range.last].max
    row_range = (min..max)
    no_beacons_ranges -= overlaps
  end

  no_beacons_ranges << row_range
end

p no_beacons_ranges.map(&:size).sum - beacons_in_y.size
