total = 0

File.readlines('input.txt', chomp: true).each do |line|
  next unless line.include?('x')

  multiplication, pieces_quantities = line.split(': ')
  multiplication = multiplication.split('x').map(&:to_i).inject(:*)
  pieces_quantities = pieces_quantities.split(' ').map(&:to_i).inject(:+)
  total += (pieces_quantities * 9) <= multiplication ? 1 : 0
end

p total
