lines = File.readlines('input.txt', chomp: true)
commands = lines.first.split('')
directions = lines[2..].map do |line|
  start, left, right = line.scan(/(\w+)/).flatten
  [start, { 'L' => left, 'R' => right }]
end.to_h

current_position = 'AAA'

result = commands.cycle.inject(0) do |acc, command|
  break acc if current_position == 'ZZZ'

  current_position = directions[current_position][command]

  acc + 1
end

p result
