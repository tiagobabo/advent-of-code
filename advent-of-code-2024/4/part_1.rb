@map = File.readlines('input.txt', chomp: true).map { |line| line.split('') }
dirs = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
total = 0

def char(y, x)
  return if y.negative? || x.negative? || y >= @map.length || x >= @map[y].length

  @map[y][x]
end

@map.each_with_index do |row, y|
  row.each_with_index do |char, x|
    next unless char == 'X'

    dirs.each do |dir|
      next unless %w[M A S].each_with_index.all? { |l, i| char(y + dir[0] * (i + 1), x + dir[1] * (i + 1)) == l }

      total += 1
    end
  end
end

p total
