ranges = []
numbers = []

File.readlines('input.txt', chomp: true).each do |line|
  next if line.empty?

  if line.include?('-')
    first, second = line.split('-')
    ranges << (first.to_i..second.to_i)
  else
    numbers << line.to_i
  end
end

total = numbers.count do |number|
  ranges.any? do |range|
    range.cover?(number)
  end
end

p total
