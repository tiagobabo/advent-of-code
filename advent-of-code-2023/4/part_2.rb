CARDS = Hash.new(0)

File.readlines('input.txt', chomp: true).each.with_index(1) do |line, index|
  _, numbers = line.split(': ')
  winning_numbers, card_numbers = numbers.split(' | ').map { |n| n.split(' ') }
  intersection = winning_numbers & card_numbers

  CARDS[index] += 1

  (index + 1..index + intersection.size).each do |n|
    CARDS[n] += CARDS[index]
  end
end

p CARDS.values.sum
