SCORES = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

score = 0

File.readlines('input.txt', chomp: true).each do |line|
  play = line.split(' ')
  score += SCORES[play.last]

  if [['A', 'Y'], ['B', 'Z'], ['C', 'X']].include?(play)
    score += 6
  elsif [['A', 'X'], ['B', 'Y'], ['C', 'Z']].include?(play)
    score += 3
  end
end

puts score
