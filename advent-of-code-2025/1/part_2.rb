current_position = 50
count = 0

File.readlines('input.txt', chomp: true).each do |line|
  direction, steps = line[0], line[1..].to_i

  case direction
  when 'L'
    steps.times do
      current_position = (current_position - 1) % 100
      count += 1 if current_position == 0
    end
  when 'R'
    steps.times do
      current_position = (current_position + 1) % 100
      count += 1 if current_position == 0
    end
  end
end

puts count
