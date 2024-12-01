list_1 = []
list_2 = []
total = 0

File.readlines('input.txt', chomp: true).each do |line|
  first, second = line.split(' ')
  list_1 << first.to_i
  list_2 << second.to_i
end

list_1.sort.zip(list_2.sort).each do |a, b|
  total += (a - b).abs
end

puts total
