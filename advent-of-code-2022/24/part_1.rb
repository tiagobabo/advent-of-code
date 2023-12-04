blizzards = []
lines = File.readlines('input.txt', chomp: true)
lines[1..-2].each_with_index do |line, y|
  line[1..-2].split('').each_with_index do |blizzard, x|
    next if blizzard == '.'

    blizzards << [x, y, blizzard]
  end
end

initial_x = lines.first.split('').find_index('.') - 1
initial_y = -1
final_x = lines.last.split('').find_index('.') - 1
final_y = lines.size - 2
max_x = lines.first.size - 2
max_y = lines[1..-2].size
states = [[initial_x, initial_y, 1]]
cache = {}
seen = {}

while states.size > 0
  x, y, minutes = states.shift

  if [x, y + 1] == [final_x, final_y]
    p minutes
    break
  end

  next if seen[[x, y, minutes]]

  seen[[x, y, minutes]] = true

  cache[minutes] ||= Array.new.tap do |new_blizzards|
    (cache[minutes - 1] || blizzards).each do |x, y, direction|
      case direction
      when '>'
        new_blizzards << [(x + 1) % max_x, y, direction]
      when '<'
        new_blizzards << [(x - 1) % max_x, y, direction]
      when '^'
        new_blizzards << [x, (y - 1) % max_y, direction]
      when 'v'
        new_blizzards << [x, (y + 1) % max_y, direction]
      end
    end
  end

  if (x + 1) < max_x && y >= 0 && !cache[minutes].any? { |x2, y2, _| x2 == (x + 1) && y2 == y }
    states << [x + 1, y, minutes + 1]
  end

  if (x - 1) >= 0 && y >= 0 && !cache[minutes].any? { |x2, y2, _| x2 == (x - 1) && y2 == y }
    states << [x - 1, y, minutes + 1]
  end

  if (y + 1) < max_y && !cache[minutes].any? { |x2, y2, _| x2 == x && y2 == (y + 1) }
    states << [x, y + 1, minutes + 1]
  end

  if (y - 1) >= 0 && !cache[minutes].any? { |x2, y2, _| x2 == x && y2 == (y - 1) }
    states << [x, y - 1, minutes + 1]
  end

  if !cache[minutes].any? { |x2, y2, _| x2 == x && y2 == y }
    states << [x, y, minutes + 1]
  end
end
