MAX_BALLS = { 'red' => 12, 'green' => 13, 'blue' => 14 }

valid_games_sum = 0

File.readlines('input.txt', chomp: true).each.with_index(1) do |line, n|
  _, rounds = line.split(': ')
  valid_round = rounds.split('; ').all? do |round|
    round.split(', ').all? do |ball|
      number, color = ball.split(' ')

      MAX_BALLS[color] >= number.to_i
    end
  end

  valid_games_sum += n if valid_round
end

p valid_games_sum
