valves = {}

File.readlines('input.txt', chomp: true).each do |line|
  tokens = line.split(' ')
  valve_name = tokens[1]
  rate = tokens[4].split('=').last[0..-2].to_i
  accessible_valves = tokens[9..-1].map { |v| v.gsub(',', '') }
  valves[valve_name] = { rate: rate, accessible_valves: accessible_valves }
end

queue = [['AA', 0, 1, []]]
seen = {}
best = 0

while queue.size > 0
  valve, score, time, unlocked = queue.shift

  next if seen.fetch([time, valve], -1) >= score

  seen[[time, valve]] = score
  best = [best, score].max

  next if time == 30

  unless unlocked.include?(valve) || valves[valve][:rate] == 0
    new_unlocked = [*unlocked, valve]
    new_score = score + new_unlocked.map { |u| valves[u][:rate] }.sum

    queue << [valve, new_score, time + 1, new_unlocked]
  end

  new_score = score + unlocked.map { |u| valves[u][:rate] }.sum
  valves[valve][:accessible_valves].each do |valve|
    queue << [valve, new_score, time + 1, unlocked]
  end
end

p best
