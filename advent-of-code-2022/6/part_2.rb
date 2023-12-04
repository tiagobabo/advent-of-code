line = File.readlines('input.txt', chomp: true).first
n = 14

while line[n-14...n].split('').uniq.length != 14
  n += 1
end

puts n
