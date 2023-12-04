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

DIRECTIONS = [:right, :down, :left, :up]
current_direction = 0
current_x = x_info[0].first
current_y = 0

def calculate_next_position(x, y, direction)
   if (50..99).include?(x) && (0..49).include?(y) # 1
    if DIRECTIONS[direction] == :up
      [0, 150 + (x - 50), DIRECTIONS.index(:right)]
    elsif DIRECTIONS[direction] == :left
      [0, 149 - y, DIRECTIONS.index(:right)]
    else
      raise 'Oooops'
    end
  elsif (100..149).include?(x) && (0..49).include?(y) # 2
    if DIRECTIONS[direction] == :up
      [x - 100, 199, DIRECTIONS.index(:up)]
    elsif DIRECTIONS[direction] == :right
      [99, 149 - y, DIRECTIONS.index(:left)]
    elsif DIRECTIONS[direction] == :down
      [99, 50 + (x - 100), DIRECTIONS.index(:left)]
    else
      raise 'Oooops'
    end
  elsif (50..99).include?(x) && (50..99).include?(y) # 3
    if DIRECTIONS[direction] == :right
      [100 + (y - 50), 49, DIRECTIONS.index(:up)]
    elsif DIRECTIONS[direction] == :left
      [y - 50, 100, DIRECTIONS.index(:down)]
    else
      raise 'Oooops'
    end
  elsif (0..49).include?(x) && (100..149).include?(y) # 4
    if DIRECTIONS[direction] == :up
      [50, 50 + x, DIRECTIONS.index(:right)]
    elsif DIRECTIONS[direction] == :left
      [50, 49 - (y - 100), DIRECTIONS.index(:right)]
    else
      raise 'Oooops'
    end
  elsif (50..99).include?(x) && (100..149).include?(y) # 5
    if DIRECTIONS[direction] == :right
      [149, 149 - y, DIRECTIONS.index(:left)]
    elsif DIRECTIONS[direction] == :down
      [49, 150 + (x - 50), DIRECTIONS.index(:left)]
    else
      raise 'Oooops'
    end
  elsif (0..49).include?(x) && (150..199).include?(y) # 6
    if DIRECTIONS[direction] == :right
      [50 + (y - 150), 149, DIRECTIONS.index(:up)]
    elsif DIRECTIONS[direction] == :down
      [100 + x, 0, DIRECTIONS.index(:down)]
    elsif DIRECTIONS[direction] == :left
      [50 + (y - 150), 0, DIRECTIONS.index(:down)]
    else
      raise 'Oooops'
    end
  else
    raise 'Oooops'
  end
end

commands = lines.last.scan(/\d+|R|L/)
i = 0

p current_x
p current_y
while commands.size > 0
  command = commands.shift

  case command
  when 'R'
    current_direction = (current_direction + 1) % DIRECTIONS.size
  when 'L'
    current_direction = (current_direction - 1) % DIRECTIONS.size
  else
    command = command.to_i
    case DIRECTIONS[current_direction]
    when :right
      command.times do |n|
        min_x, count = x_info[current_y]
        new_x, new_y, new_direction = current_x + 1, current_y, current_direction
        new_x, new_y, new_direction = calculate_next_position(current_x, current_y, current_direction) if new_x == (min_x + count)

        break if map[new_y][new_x] == '#'

        change_direction = new_direction != current_direction
        current_x, current_y, current_direction = new_x, new_y, new_direction

        p [current_x, current_y, current_direction]
        if change_direction
          commands.unshift(command - n - 1)
          break
        end
      end
    when :left
      command.times do |n|
        min_x, count = x_info[current_y]
        new_x, new_y, new_direction = current_x - 1, current_y, current_direction
        new_x, new_y, new_direction = calculate_next_position(current_x, current_y, current_direction) if new_x == (min_x - 1)

        break if map[new_y][new_x] == '#'

        change_direction = new_direction != current_direction
        current_x, current_y, current_direction = new_x, new_y, new_direction

        p [current_x, current_y, current_direction]
        if change_direction
          commands.unshift(command - n - 1)
          break
        end
      end
    when :down
      command.times do |n|
        min_y, count = y_info[current_x]
        new_x, new_y, new_direction = current_x, current_y + 1, current_direction
        new_x, new_y, new_direction = calculate_next_position(current_x, current_y, current_direction) if new_y == (min_y + count)

        break if map[new_y][new_x] == '#'

        change_direction = new_direction != current_direction
        current_x, current_y, current_direction = new_x, new_y, new_direction

        p [current_x, current_y, current_direction]
        if change_direction
          commands.unshift(command - n - 1)
          break
        end
      end
    when :up
      command.times do |n|
        min_y, count = y_info[current_x]
        new_x, new_y, new_direction = current_x, current_y - 1, current_direction
        new_x, new_y, new_direction = calculate_next_position(current_x, current_y, current_direction) if new_y == (min_y - 1)

        break if map[new_y][new_x] == '#'

        change_direction = new_direction != current_direction
        current_x, current_y, current_direction = new_x, new_y, new_direction

        p [current_x, current_y, current_direction]
        if change_direction
          commands.unshift(command - n - 1)
          break
        end
      end
    end
  end
end

p [current_x, current_y, current_direction]
p 1000 * (current_y + 1) + 4 * (current_x + 1) + current_direction
