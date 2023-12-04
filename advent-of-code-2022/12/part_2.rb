Node = Struct.new(:value, :visited)

initial_positions = []
best_signal_position = nil

map = File.readlines('input.txt', chomp: true).each_with_index.map do |row, i|
  row.split('').map.with_index do |n, j|
    if n == 'S'
      initial_position = [i, j]
      n = 'a'
    end

    if n == 'E'
      best_signal_position = [i, j]
      n = 'z'
    end

    Node.new(n, false)
  end
end

max_row = map.size
max_column = map.first.size
queue = initial_positions.map { |n| [n, 0] }

while queue.size > 0
  current_position, n = queue.shift

  if current_position == best_signal_position
    p n
    break
  end

  possible_moves = []
  possible_moves << [current_position[0] - 1, current_position[1]] unless (current_position[0] - 1) == -1
  possible_moves << [current_position[0], current_position[1] - 1] unless (current_position[1] - 1) == -1
  possible_moves << [current_position[0] + 1, current_position[1]] unless (current_position[0] + 1) == max_row
  possible_moves << [current_position[0], current_position[1] + 1] unless (current_position[1] + 1) == max_column

  at_most_char = (map[current_position[0]][current_position[1]].value.codepoints.first + 1).chr
  possible_moves.each do |move|
    next if map[move[0]][move[1]].value > at_most_char || map[move[0]][move[1]].visited

    map[move[0]][move[1]].visited = true
    queue << [move, n + 1]
  end
end
