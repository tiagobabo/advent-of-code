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
    x = 0
    line.split('').each do |char|
      if char == '#' || char == '.'
        map[[x, y]] = char
        map[[x + 1, y]] = char
        x += 2
      elsif char == 'O'
        map[[x, y]] = '['
        map[[x + 1, y]] = ']'
        x += 2
      else
        map[[x, y]] = char
        map[[x + 1, y]] = '.'
        current_position = [x, y]
        x += 2
      end
    end
  end
end

def move(position, direction, map)
  new_position = [position[0] + direction[0], position[1] + direction[1]]
  switch_position = false

  if map[new_position] == '.'
    switch_position = true
  elsif [[1, 0], [-1, 0]].include?(direction) && ['[', ']'].include?(map[new_position])
    if move(new_position, direction, map)
      switch_position = true
    end
  elsif [[0, -1], [0, 1]].include?(direction) && ['[', ']'].include?(map[new_position])
    if map[new_position] == '['
      if move_block(new_position, [new_position[0] + 1, new_position[1]], direction, map)
        switch_position = true
      end
    else
      if move_block([new_position[0] - 1, new_position[1]], new_position, direction, map)
        switch_position = true
      end
    end
  end

  if switch_position
    map[new_position] = map[position]
    map[position] = '.'
  end

  switch_position ? new_position : nil
end

def move_block(position_1, position_2, direction, map, dry_out = false)
  new_position_1 = [position_1[0] + direction[0], position_1[1] + direction[1]]
  new_position_2 = [position_2[0] + direction[0], position_2[1] + direction[1]]
  switch_position = false

  if map[new_position_1] == '.' && map[new_position_2] == '.'
    switch_position = true
  elsif map[new_position_1] == '[' && map[new_position_2] == ']'
    if move_block(new_position_1, new_position_2, direction, map, dry_out)
      switch_position = true
    end
  elsif map[new_position_1] == ']' && map[new_position_2] == '.'
    left_position = [new_position_1[0] - 1, new_position_1[1]]

    if move_block(left_position, new_position_1, direction, map, dry_out)
      switch_position = true
    end
  elsif map[new_position_1] == '.' && map[new_position_2] == '['
    right_position = [new_position_2[0] + 1, new_position_2[1]]

    if move_block(new_position_2, right_position, direction, map, dry_out)
      switch_position = true
    end
  elsif map[new_position_1] == ']' && map[new_position_2] == '['
    left_position = [new_position_1[0] - 1, new_position_1[1]]
    right_position = [new_position_2[0] + 1, new_position_2[1]]

    if move_block(left_position, new_position_1, direction, map, true) && move_block(new_position_2, right_position, direction, map, true)
      move_block(left_position, new_position_1, direction, map)
      move_block(new_position_2, right_position, direction, map)
      switch_position = true
    end
  end

  if switch_position && !dry_out
    map[new_position_1] = map[position_1]
    map[new_position_2] = map[position_2]
    map[position_1] = '.'
    map[position_2] = '.'
  end

  switch_position
end

instructions.each do |instruction|
  direction = directions[instruction]
  new_position = move(current_position, direction, map)
  current_position = new_position if new_position
end

p map.select { |_, value| value == '[' }.map { |(x, y), _| y * 100 + x }.sum
