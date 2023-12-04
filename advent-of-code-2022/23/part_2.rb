positions = {}
directions = [:up, :down, :left, :right]
first_direction = 0

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.split('').each_with_index do |elf, x|
    next if elf == '.'

    positions[[x, y]] = true
  end
end

def surrounding_positions(x, y)
  [
    [x, y + 1],
    [x, y - 1],
    [x + 1, y],
    [x - 1, y],
    [x + 1, y + 1],
    [x + 1, y - 1],
    [x - 1, y + 1],
    [x - 1, y - 1]
  ]
end

moves = 0

while true
  moves += 1
  to_move = positions.select { |(x, y), _| surrounding_positions(x, y).any? { |k| positions[k] } }

  break if to_move.empty?

  proposed_positions = to_move.map do |(x, y), _|
    4.times do |n|
      case directions[(first_direction + n) % 4]
      when :up
        next if [[x, y - 1], [x - 1, y - 1], [x + 1, y - 1]].any? { |k| positions[k] }

        break [[x, y], [x, y - 1]]
      when :down
        next if [[x, y + 1], [x - 1, y + 1], [x + 1, y + 1]].any? { |k| positions[k] }

        break [[x, y], [x, y + 1]]
      when :left
        next if [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1]].any? { |k| positions[k] }

        break [[x, y], [x - 1, y]]
      when :right
        next if [[x + 1, y], [x + 1, y - 1], [x + 1, y + 1]].any? { |k| positions[k] }

        break [[x, y], [x + 1, y]]
      end
    end
  end

  proposed_positions.group_by { |_, proposed_position| proposed_position }.each do |new_position, values|
    next if values.size > 1 || new_position.nil?

    current_position = values.first.first

    positions.delete(current_position)
    positions[new_position] = true
  end

  first_direction = (first_direction + 1) % 4
end

p moves
