filesystem = []

File.readlines('input.txt', chomp: true).each do |line|
  line.split('').each_slice(2).with_index do |(key, value), index|
    key.to_i.times { filesystem << index }

    break if value.nil?

    value.to_i.times { filesystem << nil }
  end
end

loop do
  last_position_with_value = filesystem.rindex { |value| value }
  first_free_position = filesystem.find_index(&:nil?)

  break if first_free_position > last_position_with_value

  filesystem[first_free_position] = filesystem[last_position_with_value]
  filesystem[last_position_with_value] = nil
end

total = 0

filesystem.each_with_index do |value, index|
  break if value.nil?

  total += index * value
end

p total
