map = []
timelines = []

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    map[y] ||= {}
    map[y][x] = char
    timelines[y] ||= Hash.new(0)
    timelines[y][x] = 1 if char == 'S'
  end
end

(0..map.size - 2).each do |y|
  timelines[y].each do |x, count|
    if map[y + 1][x] == '^'
      timelines[y + 1][x - 1] += count
      timelines[y + 1][x + 1] += count
    else
      timelines[y + 1][x] += count
    end
  end
end

p timelines.last.values.sum
