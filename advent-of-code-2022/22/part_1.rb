lines = File.readlines('input.txt', chomp: true)
x_info = {}
y_info = {}

map = lines[0..-3].map.with_index do |line, i|
  line = line.split('')
  x_info[i] = [line.index { |n| n != ' ' }, line.select { |n| n != ' ' }.size]

  line.each_with_index do |n, i2|
    next if n == ' '

    y_info[i2] ||= [i, 0]
    y_info[i2][1] += 1
  end

  line
end

directions = [:right, :down, :left, :up]
current_direction = 0
current_x = x_info[0].first
current_y = 0

lines.last.scan(/\d+|R|L/).each_with_index do |command, i|
  case command
  when 'R'
    current_direction = (current_direction + 1) % directions.size
  when 'L'
    current_direction = (current_direction - 1) % directions.size
  else
    command = command.to_i
    case directions[current_direction]
    when :right
      command.times do
        min_x, count = x_info[current_y]
        new_x = current_x + 1
        new_x = min_x if new_x == (min_x + count)

        break if map[current_y][new_x] == '#'

        current_x = new_x
      end
    when :left
      command.times do
        min_x, count = x_info[current_y]
        new_x = current_x - 1
        new_x = (min_x + count - 1) if new_x == (min_x - 1)

        break if map[current_y][new_x] == '#'

        current_x = new_x
      end
    when :down
      command.times do
        min_y, count = y_info[current_x]
        new_y = current_y + 1
        new_y = min_y if new_y == (min_y + count)

        break if map[new_y][current_x] == '#'

        current_y = new_y
      end
    when :up
      command.times do
        min_y, count = y_info[current_x]
        new_y = current_y - 1
        new_y = (min_y + count - 1) if new_y == (min_y - 1)

        break if map[new_y][current_x] == '#'

        current_y = new_y
      end
    end
  end
end

p 1000 * (current_y + 1) + 4 * (current_x + 1) + current_direction
