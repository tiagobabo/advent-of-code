current_position = 50
count = 0

File.readlines('input.txt', chomp: true).each do |line|
  direction, steps = line[0], line[1..].to_i

  case direction
  when 'L'
    current_position = (current_position - steps) % 100
  when 'R'
    current_position = (current_position + steps) % 100
  end

  if current_position == 0
    count += 1
  end
end

puts count
