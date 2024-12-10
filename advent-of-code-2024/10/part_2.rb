directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
map = {}
max_x, max_y = 0, 0
to_visit = []

File.readlines('input.txt', chomp: true).each.with_index do |line, y|
  max_y, max_x = y + 1, line.length

  line.split('').each_with_index do |char, x|
    map[[y, x]] = char.to_i

    to_visit << [[y, x], [y, x]] if char == '0'
  end
end

reached_nines = {}

while !to_visit.empty?
  (starting_y, starting_x), (y, x) = to_visit.shift

  directions.each do |dy, dx|
    new_y = y + dy
    new_x = x + dx

    next if new_y.negative? || new_x.negative? || new_y >= max_y || new_x >= max_x

    if map[[new_y, new_x]] == map[[y, x]] + 1
      if map[[new_y, new_x]] == 9
        reached_nines[[starting_y, starting_x]] ||= []
        reached_nines[[starting_y, starting_x]] << [new_y, new_x]
      else
        to_visit << [[starting_y, starting_x], [new_y, new_x]]
      end
    end
  end
end

p reached_nines.values.map(&:size).reduce(:+)
