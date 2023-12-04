line = File.readlines('input.txt', chomp: true).first
n = 4

while line[n-4...n].split('').uniq.length != 4
  n += 1
end

puts n
