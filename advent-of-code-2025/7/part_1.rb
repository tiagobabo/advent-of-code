map = []
splits = 0

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    map[y] ||= {}
    map[y][x] = char
  end
end

(0..map.size - 2).each do |y|
  map[y].filter { |_, char| char == 'S' }.each do |x, _|
    if map[y + 1][x] == '^'
      map[y + 1][x - 1] = 'S'
      map[y + 1][x + 1] = 'S'

      splits += 1
    else
      map[y + 1][x] = 'S'
    end
  end
end

p splits
