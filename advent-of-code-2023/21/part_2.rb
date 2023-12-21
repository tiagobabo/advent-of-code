require 'set'

directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
rocks = Set.new
starting_position = nil
max_x = 0
max_y = 0
File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  max_x = x + 1
  max_y = line.length
  line.split('').each_with_index do |char, y|
    starting_position = [x, y] if char == 'S'
    rocks << [x, y] if char == '#'
  end
end

queue = [starting_position].to_set
heatmap = {}

1000.times do |i|
  new_queue = Set.new

  queue.each do |x, y|
    directions.each do |dx, dy|
      new_x = x + dx
      new_y = y + dy

      new_queue << [new_x, new_y] unless rocks.include?([new_x % max_x, new_y % max_y])
    end
  end

  queue = new_queue
  heatmap = queue.map { |x, y| [x % max_x, y % max_y] }.tally
  p [i, heatmap.values.sort.tally]
end

p queue.size
p heatmap.values.sort.tally.map { |k, v| k * v }.sum

# By running this for a while it's possible to find a cycle every 131 positioons with 3 keys
# Those 3 keys can be calculated
# First key: cycle ** 2
# Second key: (cycle ** 2 + cycle)
# Third key: (cycle + 1) ** 2
# Using this formula it's possible to calculate the final value
# 26501365 / 131 = 202300 - number of complete cycles
# 26501365 % 131 = 65 - number of iterations in the last incomplete cycle
# Grabbing the multipliers from iteration 65 of the cycle:
# 202300**2 * 3724 + (202300**2 + 202300)*7486 + ((202300+1)**2) * 3814
# 614864614526014
