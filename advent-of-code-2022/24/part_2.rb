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
blizzards_cache = {}
seen = {}
minutes_total = 1
not_allowed_positions_cache = {}

3.times do |n|
  if n == 1
    states = [[final_x, final_y, minutes_total]]
  else
    states = [[initial_x, initial_y, minutes_total]]
  end

  while states.size > 0
    x, y, minutes = states.shift

    if n == 1
      if [x, y - 1] == [initial_x, initial_y]
        minutes_total = minutes
        break
      end
    else
      if [x, y + 1] == [final_x, final_y]
        minutes_total = minutes
        break
      end
    end

    next if seen[[x, y, minutes]]

    seen[[x, y, minutes]] = true

    blizzards_cache[minutes] ||= Array.new.tap do |new_blizzards|
      not_allowed_positions_cache[minutes] = {}
      (blizzards_cache[minutes - 1] || blizzards).each do |x, y, direction|
        case direction
        when '>'
          not_allowed_positions_cache[minutes][[(x + 1) % max_x, y]] = true
          new_blizzards << [(x + 1) % max_x, y, direction]
        when '<'
          not_allowed_positions_cache[minutes][[(x - 1) % max_x, y]] = true
          new_blizzards << [(x - 1) % max_x, y, direction]
        when '^'
          not_allowed_positions_cache[minutes][[x, (y - 1) % max_y]] = true
          new_blizzards << [x, (y - 1) % max_y, direction]
        when 'v'
          not_allowed_positions_cache[minutes][[x, (y + 1) % max_y]] = true
          new_blizzards << [x, (y + 1) % max_y, direction]
        end
      end
    end

    if (x + 1) < max_x && y >= 0 && y < max_y && !not_allowed_positions_cache[minutes][[x + 1, y]]
      states << [x + 1, y, minutes + 1]
    end

    if (x - 1) >= 0 && y >= 0 && y < max_y && !not_allowed_positions_cache[minutes][[x - 1, y]]
      states << [x - 1, y, minutes + 1]
    end

    if (y + 1) < max_y && !not_allowed_positions_cache[minutes][[x, y + 1]]
      states << [x, y + 1, minutes + 1]
    end

    if (y - 1) >= 0 && !not_allowed_positions_cache[minutes][[x, y - 1]]
      states << [x, y - 1, minutes + 1]
    end

    if !not_allowed_positions_cache[minutes][[x, y]]
      states << [x, y, minutes + 1]
    end
  end
end

p minutes_total
