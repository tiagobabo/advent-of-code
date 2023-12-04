scores = []
current = 0

File.readlines('input.txt', chomp: true).each do |line|
  if line.empty?
    scores.push(current)
    current = 0
  else
    current += line.to_i
  end
end

puts scores.sort.reverse.take(3).sum
