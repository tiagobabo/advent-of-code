def count_horizontal_mirrors(maps)
  result = 0

  maps.each do |map|
    rows = map.size
    (0..rows - 1).each_cons(2) do |row_1, row_2|
      if map[row_1] == map[row_2]

        min = [(0...row_1).size, (row_2 + 1..rows - 1).size].min

        if map[row_1 - min...row_1] == map[row_2 + 1..row_2 + min].reverse
          result += (row_1 + 1)

          break
        end
      end
    end
  end

  result
end

maps = []
map_index = 0

File.readlines('input.txt', chomp: true).each do |line|
  if line.empty?
    map_index += 1
  else
    line = line.split('')
    maps[map_index] ||= []
    maps[map_index] << line
  end
end

p count_horizontal_mirrors(maps) * 100 + count_horizontal_mirrors(maps.map(&:transpose))
