sum = 0

File.readlines('input.txt', chomp: true).each do |line|
  digits = line.split('')
  sum += digits.reverse.each_with_index.sum do |digit, i|
    digit = -1 if digit == '-'
    digit = -2 if digit == '='

    digit.to_i * (5 ** i)
  end
end

p sum
