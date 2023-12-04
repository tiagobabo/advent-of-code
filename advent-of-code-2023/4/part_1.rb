sum = 0

File.readlines('input.txt', chomp: true).each.with_index(1) do |line, n|
  _, numbers = line.split(': ')
  winning_numbers, card_numbers = numbers.split(' | ').map { |n| n.split(' ') }
  intersection = winning_numbers & card_numbers

  next if intersection.empty?

  sum += 2 ** ((winning_numbers & card_numbers).size - 1)
end

p sum.to_i
