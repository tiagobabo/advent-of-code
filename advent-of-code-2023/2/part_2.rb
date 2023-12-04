power_sum = 0

File.readlines('input.txt', chomp: true).each.with_index(1) do |line, n|
  _, rounds = line.split(': ')

  max = { 'red' => 0, 'green' => 0, 'blue' => 0 }

  rounds.split('; ').each do |round|
    round_max = { 'red' => 0, 'green' => 0, 'blue' => 0 }

    round.split(', ').each do |ball|
      number, color = ball.split(' ')
      round_max[color] = number.to_i
    end

    max.each do |color, number|
      max[color] = round_max[color] if round_max[color] > number
    end
  end

  power_sum += max.values.reduce(:*)
end

p power_sum
