largest_joltages = []

File.readlines('input.txt', chomp: true).each do |line|
  digits = line.split('')
  largest_joltage = 0

  digits.combination(2).each do |combination|
    joltage = combination.join.to_i
    largest_joltage = [largest_joltage, joltage].max
  end

  largest_joltages << largest_joltage
end

p largest_joltages.sum
