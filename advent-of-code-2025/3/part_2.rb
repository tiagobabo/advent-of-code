largest_joltages = []

def find_largest_joltage(digits, largest_joltage)
  return largest_joltage.join.to_i if largest_joltage.size == 12

  next_max_digit = digits[..-12 + largest_joltage.size].max
  next_max_digit_index = digits.index(next_max_digit)

  find_largest_joltage(digits[next_max_digit_index + 1..], largest_joltage + [next_max_digit])
end

File.readlines('input.txt', chomp: true).each do |line|
  digits = line.split('').map(&:to_i)
  max_digit_index = digits.index(digits[..-12].max)

  largest_joltages << find_largest_joltage(digits[max_digit_index + 1..-1], [digits[max_digit_index]])
end

p largest_joltages.sum
