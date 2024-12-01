list = []
occurrences = Hash.new(0)
total = 0

File.readlines('input.txt', chomp: true).each do |line|
  first, second = line.split(' ')
  list << first.to_i
  occurrences[second.to_i] += 1
end

list.each do |a|
  total += a * occurrences[a]
end

puts total
