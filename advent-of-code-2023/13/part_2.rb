def count_horizontal_mirrors(maps)
  result = 0

  maps.each_with_index do |map, i|
    rows = map.size

    (0..rows - 1).each_cons(2) do |row_1, row_2|
      differences = map[row_1].zip(map[row_2]).count { |x, y| x != y }
      flipped = differences == 1

      if differences <= 1
        min = [(0...row_1).size, (row_2 + 1..rows - 1).size].min
        pairs = (row_1 - min...row_1).zip((row_2 + 1..row_2 + min).to_a.reverse)

        all_match = pairs.all? do |pair_1, pair_2|
          differences = map[pair_1].zip(map[pair_2]).count { |x, y| x != y }

          if differences == 0
            true
          elsif differences == 1 && !flipped
            flipped = true
            true
          else
            false
          end
        end

        if flipped && all_match
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
