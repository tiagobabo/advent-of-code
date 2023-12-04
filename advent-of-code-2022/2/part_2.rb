SCORES = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

WIN = {
  'A' => 'Y',
  'B' => 'Z',
  'C' => 'X'
}

DRAW = {
  'A' => 'X',
  'B' => 'Y',
  'C' => 'Z'
}

LOSE = {
  'A' => 'Z',
  'B' => 'X',
  'C' => 'Y'
}

score = 0

File.readlines('input.txt', chomp: true).each do |line|
  opponent, me = line.split(' ')

  if me == 'X'
    me = LOSE[opponent]
  elsif me == 'Y'
    me = DRAW[opponent]
  else
    me = WIN[opponent]
  end

  score += SCORES[me]
  play = [opponent, me]

  if [['A', 'Y'], ['B', 'Z'], ['C', 'X']].include?(play)
    score += 6
  elsif [['A', 'X'], ['B', 'Y'], ['C', 'Z']].include?(play)
    score += 3
  end
end

puts score
