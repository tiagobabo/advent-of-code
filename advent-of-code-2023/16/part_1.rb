map = File.readlines('input.txt', chomp: true).map do |line|
  line.split('')
end

max_x = map.size - 1
max_y = map.first.size - 1

queue = [[0, 0, :right]]
seen = []

until queue.empty?
  point = queue.pop
  x, y, direction = point

  next if seen.include?([x, y, direction])

  seen << [x, y, direction]

  value = map[x][y]

  if value == '.' || (value == '-' && (direction == :right || direction == :left)) || (value == '|' && (direction == :up || direction == :down))
    case direction
    when :right
      queue << [x, y + 1, direction] unless y == max_y
    when :left
      queue << [x, y - 1, direction] unless y == 0
    when :up
      queue << [x - 1, y, direction] unless x == 0
    when :down
      queue << [x + 1, y, direction] unless x == max_x
    end
  elsif value == '-'
    queue << [x, y - 1, :left] unless y == 0
    queue << [x, y + 1, :right] unless y == max_y
  elsif value == '|'
    queue << [x - 1, y, :up] unless x == 0
    queue << [x + 1, y, :down] unless x == max_x
  elsif value == '/'
    case direction
    when :right
      queue << [x - 1, y, :up] unless x == 0
    when :left
      queue << [x + 1, y, :down] unless x == max_x
    when :up
      queue << [x, y + 1, :right] unless y == max_y
    when :down
      queue << [x, y - 1, :left] unless y == 0
    end
  elsif value == '\\'
    case direction
    when :right
      queue << [x + 1, y, :down] unless x == max_x
    when :left
      queue << [x - 1, y, :up] unless x == 0
    when :up
      queue << [x, y - 1, :left] unless y == 0
    when :down
      queue << [x, y + 1, :right] unless y == max_y
    end
  end
end

p seen.map { |x, y, _| [x, y] }.uniq.size
