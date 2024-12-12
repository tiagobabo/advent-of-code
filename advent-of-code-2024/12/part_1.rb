flowers = {}

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.split('').each_with_index do |char, x|
    flowers[[y, x]] = char
  end
end

total = 0
visited = Set.new

flowers.each do |key, char|
  next if visited.include?(key)

  total_area = 0
  total_perimeter = 0
  neighbors = Set[key]

  while neighbors.length > 0
    y, x = neighbors.first

    neighbors.delete([y, x])

    next if visited.include?([y, x])

    visited << [y, x]

    total_area += 1

    [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]].each do |y, x|
      if flowers[[y, x]] != char
        total_perimeter += 1
      else
        neighbors << [y, x] unless visited.include?([y, x])
      end
    end
  end

  total += total_area * total_perimeter
end

p total
