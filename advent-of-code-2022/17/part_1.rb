
def find_next_rock(next_rock, top_y)
  case next_rock
  when 1
    [[2, top_y + 3], [3, top_y + 3], [4, top_y + 3], [5, top_y + 3]]
  when 2
    [[3, top_y + 3], [2, top_y + 4], [3, top_y + 4], [4, top_y + 4], [3, top_y + 5]]
  when 3
    [[2, top_y + 3], [3, top_y + 3], [4, top_y + 3], [4, top_y + 4], [4, top_y + 5]]
  when 4
    [[2, top_y + 3], [2, top_y + 4], [2, top_y + 5], [2, top_y + 6]]
  when 5
    [[2, top_y + 3], [3, top_y + 3], [2, top_y + 4], [3, top_y + 4]]
  end
end

max_x = 6
rocks = []
top_y = 0
next_rock = 1
current_rock = find_next_rock(next_rock, top_y)
patterns = File.readlines('input.txt', chomp: true).first.split('')
current_pattern = 0
rocks_total = 0

while rocks_total < 2022
  case patterns[current_pattern % patterns.size]
  when '<'
    unless current_rock.map(&:first).min == 0 || rocks.any? { |rock| rock.any? { |x1, y1| current_rock.any? { |x2, y2| x1 == x2 - 1 && y1 == y2 } } }
      current_rock.each do |position|
        position[0] -= 1
      end
    end
  else
    unless current_rock.map(&:first).max == max_x || rocks.any? { |rock| rock.any? { |x1, y1| current_rock.any? { |x2, y2| x1 == x2 + 1 && y1 == y2 } } }
      current_rock.each do |position|
        position[0] += 1
      end
    end
  end

  if current_rock.map(&:last).min == 0 || rocks.any? { |rock| rock.any? { |x1, y1| current_rock.any? { |x2, y2| y1 == y2 - 1 && x1 == x2 } } }
    rocks << current_rock
    rocks_total += 1
    rocks.shift if rocks.size > 50
    top_y = rocks.flat_map { |rock| rock.map(&:last) }.max + 1
    next_rock = next_rock % 5 + 1
    current_rock = find_next_rock(next_rock, top_y)
  else
    current_rock.each do |position|
      position[1] -= 1
    end
  end

  current_pattern += 1
end

p top_y
