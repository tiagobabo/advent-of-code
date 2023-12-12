def recursive_count(line, sizes, group_count = 0, cache = {})
  cache_key = [line, sizes, group_count]

  return cache[cache_key] if cache.key?(cache_key)

  if line.empty?
    return sizes.empty? && group_count == 0 ? 1 : 0
  end

  total = 0
  next_positions = line[0] == '?' ? ['.', '#'] : [line[0]]

  next_positions.each do |position|
    if position == '#'
      total += recursive_count(line[1..], sizes, group_count + 1, cache)
    else
      if group_count > 0
        if sizes[0] == group_count
          total += recursive_count(line[1..], sizes[1..], 0, cache)
        end
      else
        total += recursive_count(line[1..], sizes, 0, cache)
      end
    end
  end

  cache[cache_key] = total

  total
end

result = File.readlines('input.txt', chomp: true).each.inject(0) do |acc, line|
  springs, valid_permutations = line.split(' ')
  springs = (springs << '?') * 5
  valid_permutations = valid_permutations.split(',').map(&:to_i) * 5
  acc + recursive_count(springs[0..-2] + '.', valid_permutations)
end

p result
