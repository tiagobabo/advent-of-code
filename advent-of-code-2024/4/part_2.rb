@map = File.readlines('input.txt', chomp: true).map { |line| line.split('') }
total = 0

def char(y, x)
  return if y.negative? || x.negative? || y >= @map.length || x >= @map[y].length

  @map[y][x]
end

@map.each_with_index do |row, y|
  row.each_with_index do |char, x|
    next unless char == 'A'

    if Set[char(y - 1, x - 1), char(y + 1, x + 1)] == Set['M', 'S'] &&
       Set[char(y - 1, x + 1), char(y + 1, x - 1)] == Set['M', 'S']
      total += 1
    end
  end
end

p total
