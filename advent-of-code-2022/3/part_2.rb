score = 0
File.readlines('input.txt', chomp: true).each_slice(3) do |line1, line2, line3|
  common_element = (line1.split('') & line2.split('') & line3.split('')).first
  score += (('a'..'z').to_a + ('A'..'Z').to_a).find_index(common_element) + 1
end

puts score
