map = {}
instructions = []
parsing_instructions = false
current_position = nil
directions = { '>' => [1, 0], '<' => [-1, 0], '^' => [0, -1], 'v' => [0, 1] }

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  if line.empty?
    parsing_instructions = true
  elsif parsing_instructions
    instructions.append(*line.split(''))
  else
    line.split('').each_with_index do |char, x|
      map[[x, y]] = char
      current_position = [x, y] if char == '@'
    end
  end
end

def move(position, direction, map)
  new_position = [position[0] + direction[0], position[1] + direction[1]]
  switch_position = false
  if map[new_position] == '.'
    switch_position = true
  elsif map[new_position] == 'O'
    if move(new_position, direction, map)
      switch_position = true
    end
  end

  if switch_position
    map[new_position] = map[position]
    map[position] = '.'
  end

  switch_position ? new_position : nil
end

instructions.each do |instruction|
  direction = directions[instruction]
  new_position = move(current_position, direction, map)
  current_position = new_position if new_position
end

p map.select { |_, value| value == 'O' }.map { |(x, y), _| y * 100 + x }.sum
