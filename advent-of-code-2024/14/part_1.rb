robots = []
max_x = 101
max_y = 103

File.readlines('input.txt', chomp: true).each do |robot|
  position, velocity = robot.split(' ')
  position = position.split('=').last.split(',').map(&:to_i)
  velocity = velocity.split('=').last.split(',').map(&:to_i)

  robots << [position, velocity]
end

100.times do
  robots.each do |position, velocity|
    position[0] = (position[0] + velocity[0]) % max_x
    position[1] = (position[1] + velocity[1]) % max_y
  end
end

quadrant_1, quadrant_2, quadrant_3, quadrant_4 = 0, 0, 0, 0

robots.each do |position, _|
  if position[0] < max_x / 2 && position[1] < max_y / 2
    quadrant_1 += 1
  elsif position[0] > max_x / 2 && position[1] < max_y / 2
    quadrant_2 += 1
  elsif position[0] < max_x / 2 && position[1] > max_y / 2
    quadrant_3 += 1
  elsif position[0] > max_x / 2 && position[1] > max_y / 2
    quadrant_4 += 1
  end
end

p [quadrant_1, quadrant_2, quadrant_3, quadrant_4].reduce(:*)

