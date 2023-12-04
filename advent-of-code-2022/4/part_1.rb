score = 0

File.readlines('input.txt', chomp: true).each do |line|
  elf1, elf2 = line.split(',')
  range1_min, range1_max = elf1.split('-').map(&:to_i)
  range2_min, range2_max = elf2.split('-').map(&:to_i)

  if range1_min <= range2_min && range1_max >= range2_max
    score += 1
  elsif range2_min <= range1_min && range2_max >= range1_max
    score += 1
  end
end

puts score
