numbers = File.readlines('input.txt', chomp: true).map.with_index { |n, i| [n.to_i * 811589153, i] }

10.times do
  numbers.size.times do |n|
    index = numbers.index { |_, i| i == n }
    tuple = numbers.delete_at(index)

    numbers.insert((index + tuple[0]) % numbers.size, tuple)
  end
end

zero = numbers.index { |number, _| number == 0}
number_1000 = numbers[(zero + 1000) % numbers.size][0]
number_2000 = numbers[(zero + 2000) % numbers.size][0]
number_3000 = numbers[(zero + 3000) % numbers.size][0]

p number_1000 + number_2000 + number_3000

