valves = {}

File.readlines('input.txt', chomp: true).each do |line|
  tokens = line.split(' ')
  valve_name = tokens[1]
  rate = tokens[4].split('=').last[0..-2].to_i
  accessible_valves = tokens[9..-1].map { |v| v.gsub(',', '') }
  valves[valve_name] = { rate: rate, accessible_valves: accessible_valves }
end

queue = [['AA', 'AA', 0, 1, []]]
seen = {}
best = 0

while queue.size > 0
  valve_1, valve_2, score, time, unlocked = queue.shift

  next if seen.fetch([time, valve_1, valve_2], -1) >= score

  seen[[time, valve_1, valve_2]] = score
  best = [best, score].max

  next if time == 26

  unless unlocked.include?(valve_1) || valves[valve_1][:rate] == 0
    unless unlocked.include?(valve_2) || valves[valve_2][:rate] == 0
      new_unlocked = [*unlocked, valve_1, valve_2]
      new_score = score + new_unlocked.map { |u| valves[u][:rate] }.sum

      queue << [valve_1, valve_2, new_score, time + 1, new_unlocked]
    end

    new_unlocked = [*unlocked, valve_1]
    new_score = score + new_unlocked.map { |u| valves[u][:rate] }.sum

    valves[valve_2][:accessible_valves].each do |valve|
      queue << [valve_1, valve, new_score, time + 1, new_unlocked]
    end
  end

  unless unlocked.include?(valve_2) || valves[valve_2][:rate] == 0
    unless unlocked.include?(valve_1) || valves[valve_1][:rate] == 0
      new_unlocked = [*unlocked, valve_1, valve_2]
      new_score = score + new_unlocked.map { |u| valves[u][:rate] }.sum

      queue << [valve_1, valve_2, new_score, time + 1, new_unlocked]
    end

    new_unlocked = [*unlocked, valve_2]
    new_score = score + new_unlocked.map { |u| valves[u][:rate] }.sum

    valves[valve_1][:accessible_valves].each do |valve|
      queue << [valve, valve_2, new_score, time + 1, new_unlocked]
    end
  end

  new_score = score + unlocked.map { |u| valves[u][:rate] }.sum
  valves[valve_1][:accessible_valves].each do |valve_1|
    valves[valve_2][:accessible_valves].each do |valve_2|
      next if valve_1 == valve_2

      queue << [valve_1, valve_2, new_score, time + 1, unlocked]
    end
  end
end

p best
