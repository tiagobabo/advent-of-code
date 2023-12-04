total = 0

File.readlines('input.txt', chomp: true).each do |line|
  scanned = line.scan(/\d/)
  total += "#{scanned.first}#{scanned.last}".to_i
end

puts total
