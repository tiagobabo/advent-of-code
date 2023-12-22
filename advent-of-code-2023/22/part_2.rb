Brick = Struct.new(:i, :points, :max_z, :min_z, :supporting)

bricks = []

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  first, last = line.split('~')
  first_x, first_y, first_z = first.split(',').map(&:to_i)
  second_x, second_y, last_z = last.split(',').map(&:to_i)
  brick = Brick.new(i, [], 0, 0, [])
  (first_x..second_x).each do |x|
    (first_y..second_y).each do |y|
      (first_z..last_z).each do |z|
        brick.points << [x, y, z]
      end
    end
  end

  brick.min_z = brick.points.map(&:last).min
  brick.max_z = brick.points.map(&:last).max

  bricks << brick
end

max_z = bricks.map { |brick| brick.points.map(&:last).min }.max

(2..max_z).to_a.each do |z|
  bricks.select { |brick| brick.min_z == z }.each do |brick|
    while true do
      new_points = brick.points.map { |point| [point[0], point[1], point[2] - 1] }
      new_min_z = new_points.map(&:last).min

      break if new_min_z == 0

      max_reached = false
      bricks_in_new_z = bricks.select { |brick| brick.max_z == new_min_z }

      Array(bricks_in_new_z).each do |other_brick|
        if (new_points & other_brick.points).any?
          max_reached = true
          other_brick.supporting << brick.i
        end
      end

      break if max_reached

      brick.points = new_points
      brick.min_z = new_min_z
      brick.max_z = brick.points.map(&:last).max
    end
  end
end

result = bricks.inject(0) do |sum, block|
  desintegrating_bricks = [block.i]
  desintegrated_bricks = []
  n = 0
  while desintegrating_bricks.any? do
    desintegrated_bricks += desintegrating_bricks

    desintegrating_bricks = desintegrating_bricks.flat_map do |i|
      bricks[i].supporting.reject do |supporting_brick|
        bricks.reject { |b| desintegrated_bricks.include?(b.i) }.any? { |other_brick| other_brick.supporting.include?(supporting_brick) }
      end
    end.uniq

    n += desintegrating_bricks.size
  end

  sum + n
end

p result
