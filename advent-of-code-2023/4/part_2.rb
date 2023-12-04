CARDS = Hash.new(0)

File.readlines('input.txt', chomp: true).each.with_index(1) do |line, index|
  _, numbers = line.split(': ')
  winning_numbers, card_numbers = numbers.split(' | ').map { |n| n.split(' ') }
  intersection = winning_numbers & card_numbers
  winning_numbers_count = intersection.size

  CARDS[index] += 1
  CARDS[index].times do
    (index + 1..index + winning_numbers_count).each do |n|
      CARDS[n] += 1
    end
  end
end

p CARDS.values.sum
