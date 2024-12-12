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
  neighbors = Set[key]
  total_vertices = 0

  while neighbors.length > 0
    y, x = neighbors.first
    neighbors.delete([y, x])

    next if visited.include?([y, x])

    visited << [y, x]

    total_area += 1

    directions = [
      [[1, -1], [[0, -1], [1, 0]]],   # Bottom-left diagonal
      [[-1, -1], [[0, -1], [-1, 0]]], # Top-left diagonal
      [[-1, 1], [[0, 1], [-1, 0]]],   # Top-right diagonal
      [[1, 1], [[0, 1], [1, 0]]]      # Bottom-right diagonal
    ]

    directions.each do |diagonal, (first_adjacent, second_adjecent)|
      diagonal = [y + diagonal[0], x + diagonal[1]]
      adj1 = [y + first_adjacent[0], x + first_adjacent[1]]
      adj2 = [y + second_adjecent[0], x + second_adjecent[1]]

      if flowers[diagonal] != char
        if (flowers[adj1] == char && flowers[adj2] == char) || # Inner vertex
          (flowers[adj1] != char && flowers[adj2] != char)     # Outer vertex
          total_vertices += 1
        end
      elsif flowers[diagonal] == char && flowers[adj1] != char && flowers[adj2] != char # Outer vertex touching a different shape with the same letter
        total_vertices += 1
      end
    end

    [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]].each do |y, x|
      next if flowers[[y, x]] != char || visited.include?([y, x])

      neighbors << [y, x] unless visited.include?([y, x])
    end
  end

  total += total_area * total_vertices
end

p total
