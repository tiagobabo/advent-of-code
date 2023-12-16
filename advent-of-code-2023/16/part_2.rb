MAP = File.readlines('input.txt', chomp: true).map do |line|
  line.split('')
end

MAX_X = MAP.size - 1
MAX_Y = MAP.first.size - 1

def calculate_energized_tiles(x, y, direction)
  queue = [[x, y, direction]]
  count = 0
  seen = {}

  until queue.empty?
    point = queue.pop
    x, y, direction = point
    seen[[x, y]] ||= {}

    next if seen[[x, y]][direction]

    seen[[x, y]][direction] = true

    value = MAP[x][y]

    if value == '.' || (value == '-' && (direction == :right || direction == :left)) || (value == '|' && (direction == :up || direction == :down))
      case direction
      when :right
        queue << [x, y + 1, direction] unless y == MAX_Y
      when :left
        queue << [x, y - 1, direction] unless y == 0
      when :up
        queue << [x - 1, y, direction] unless x == 0
      when :down
        queue << [x + 1, y, direction] unless x == MAX_X
      end
    elsif value == '-'
      queue << [x, y - 1, :left] unless y == 0
      queue << [x, y + 1, :right] unless y == MAX_Y
    elsif value == '|'
      queue << [x - 1, y, :up] unless x == 0
      queue << [x + 1, y, :down] unless x == MAX_X
    elsif value == '/'
      case direction
      when :right
        queue << [x - 1, y, :up] unless x == 0
      when :left
        queue << [x + 1, y, :down] unless x == MAX_X
      when :up
        queue << [x, y + 1, :right] unless y == MAX_Y
      when :down
        queue << [x, y - 1, :left] unless y == 0
      end
    elsif value == '\\'
      case direction
      when :right
        queue << [x + 1, y, :down] unless x == MAX_X
      when :left
        queue << [x - 1, y, :up] unless x == 0
      when :up
        queue << [x, y - 1, :left] unless y == 0
      when :down
        queue << [x, y + 1, :right] unless y == MAX_Y
      end
    end
  end

  seen.keys.size
end

right = (0..MAX_X).map do |x|
  calculate_energized_tiles(x, 0, :right)
end

left = (0..MAX_X).map do |x|
  calculate_energized_tiles(x, MAX_Y, :left)
end

up = (0..MAX_Y).map do |y|
  calculate_energized_tiles(MAX_X, y, :up)
end

down = (0..MAX_Y).map do |y|
  calculate_energized_tiles(0, y, :down)
end

p (right + left + up + down).max
