points = []

def area(p1, p2)
  ((p1[0] - p2[0]).abs + 1) * ((p1[1] - p2[1]).abs + 1)
end

File.readlines('input.txt', chomp: true).each do |line|
  points << line.split(',').map(&:to_i)
end

p points.combination(2).map { |a, b| area(a, b) }.max
