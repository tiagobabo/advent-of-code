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
  visited = Set.new

  robots.each do |position, velocity|
    position[0] = (position[0] + velocity[0]) % max_x
    position[1] = (position[1] + velocity[1]) % max_y

    visited << position
  end

  if visited.size == robots.size
    p i + 1

    grid = Array.new(max_y) { Array.new(max_x, '.') }

    robots.each do |position, _|
      grid[position[1]][position[0]] = '#'
    end

    grid.each do |row|
      puts row.join
    end

    break
  end
end
