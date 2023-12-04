BOXES = {
  '1' => ['R', 'W', 'F', 'H', 'T', 'S'],
  '2' => ['W', 'Q', 'D', 'G', 'S'],
  '3' => ['W', 'T', 'B'],
  '4' => ['J', 'Z', 'Q', 'N', 'T', 'W', 'R', 'D'],
  '5' => ['Z', 'T', 'V', 'L', 'G', 'H', 'B', 'F'],
  '6' => ['G', 'S', 'B', 'V', 'C', 'T', 'P', 'L'],
  '7' => ['P', 'G', 'W', 'T', 'R', 'B', 'Z'],
  '8' => ['R', 'J', 'C', 'T', 'M', 'G', 'N'],
  '9' => ['W', 'B', 'G', 'L']
}

File.readlines('input.txt', chomp: true).each_with_index do |line, index|
  next if index <= 9

  _, n, _, from, _, to = line.split(' ')

  elements = BOXES[from].slice!(0, n.to_i)
  BOXES[to].unshift(*elements)
end

puts BOXES.values.map(&:first).join
