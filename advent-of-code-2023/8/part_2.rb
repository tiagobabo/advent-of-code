lines = File.readlines('input.txt', chomp: true)
commands = lines.first.split('')
directions = lines[2..].map do |line|
  start, left, right = line.scan(/(\w+)/).flatten
  [start, { 'L' => left, 'R' => right }]
end.to_h

results = directions.keys.select { |k| k[-1] == 'A' }.map do |current_position|
  commands.cycle.inject(0) do |acc, command|
    break acc if current_position[-1] == 'Z'

    current_position = directions[current_position][command]

    acc + 1
  end
end

p results.reduce(1, :lcm)
