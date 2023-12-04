max = 0
current = 0

File.readlines('input.txt', chomp: true).each do |line|
  if line.empty?
    max = current if current > max
    current = 0
  else
    current += line.to_i
  end
end

puts max
