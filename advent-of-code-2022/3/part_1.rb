score = 0
File.readlines('input.txt', chomp: true).each do |line|
  first, second = line.slice!(0...(line.length/2)), line
  common_element = (first.split('') & second.split('')).first

  score += (('a'..'z').to_a + ('A'..'Z').to_a).find_index(common_element) + 1
end

puts score
