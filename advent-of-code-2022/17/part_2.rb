
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
cache = {}
rocks_total = 0
iterations = 0
division_module = nil
top_y_initial = nil
rocks_total_initial = nil
top_y_final = nil
rocks_total_final = nil
missing = 0

while true
  iterations += 1
  case patterns[current_pattern]
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
    rocks.shift if rocks.size > 100
    top_y = rocks.flat_map { |rock| rock.map(&:last) }.max + 1

    if division_module != nil
      break if division_module == 0

      missing = top_y - top_y_final
      division_module -= 1
    end

    if iterations > patterns.size
      if cache[[current_pattern, next_rock]] && division_module == nil
        rocks_total_final = rocks_total
        top_y_final = top_y
        top_y_initial, rocks_total_initial = cache[[current_pattern, next_rock]]
        rocks_increase = rocks_total_final - rocks_total_initial
        rocks_missing = 1000000000000 - rocks_total_initial
        division_module = rocks_missing % rocks_increase
      else
        cache[[current_pattern, next_rock]] = [top_y, rocks_total]
      end
    end

    next_rock = next_rock % 5 + 1
    current_rock = find_next_rock(next_rock, top_y)
  else
    current_rock.each do |position|
      position[1] -= 1
    end
  end

  current_pattern = (current_pattern + 1) % patterns.size
end

y_increase = top_y_final - top_y_initial
rocks_increase = rocks_total_final - rocks_total_initial
rocks_missing = 1000000000000 - rocks_total_initial
division_module = rocks_missing % rocks_increase

p top_y_initial + ((rocks_missing - division_module) / rocks_increase) * y_increase + missing
