require 'oily_png'

robots = []
max_x = 101
max_y = 103

File.readlines('input.txt', chomp: true).each do |robot|
  position, velocity = robot.split(' ')
  position = position.split('=').last.split(',').map(&:to_i)
  velocity = velocity.split('=').last.split(',').map(&:to_i)

  robots << [position, velocity]
end

10_000.times do |i|
  robots.each do |position, velocity|
    position[0] = (position[0] + velocity[0]) % max_x
    position[1] = (position[1] + velocity[1]) % max_y
  end

  png = ChunkyPNG::Image.new(max_x, max_y, ChunkyPNG::Color::WHITE)

  robots.each do |position, _|
    png[position[0], position[1]] = ChunkyPNG::Color::BLACK
  end

  png.save("output/#{i + 1}.png")
end
