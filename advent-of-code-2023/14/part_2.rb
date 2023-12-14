require 'ostruct'

def run_cycle(rocks, total_x, total_y)
  ['N', 'W', 'S', 'E'].each do |direction|
    last_rocks = {}

    case direction
    when 'N'
      rocks.sort_by { |r| r[0] }.each do |rock|
        rock[0] = (last_rocks[rock[1]] ? last_rocks[rock[1]][0] + 1 : 0) if rock[2] == 'O'
        last_rocks[rock[1]] = rock
      end
    when 'S'
      rocks.sort_by { |r| -r[0] }.each do |rock|
        rock[0] = (last_rocks[rock[1]] ? last_rocks[rock[1]][0] - 1 : total_x - 1) if rock[2] == 'O'
        last_rocks[rock[1]] = rock
      end
    when 'W'
      rocks.sort_by { |r| r[1] }.each do |rock|
        rock[1] = (last_rocks[rock[0]] ? last_rocks[rock[0]][1] + 1 : 0) if rock[2] == 'O'
        last_rocks[rock[0]] = rock
      end
    when 'E'
      rocks.sort_by { |r| -r[1] }.each do |rock|
        rock[1] = (last_rocks[rock[0]] ? last_rocks[rock[0]][1] - 1 : total_y - 1) if rock[2] == 'O'
        last_rocks[rock[0]] = rock
      end
    end
  end
end

rocks = []
total_x = 0
total_y = 0

File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  line.split('').each_with_index do |rock, y|
    next if rock == '.'

    rocks << [x, y, rock]
  end

  total_x += 1
  total_y = line.length
end

cache = []
cache_key = nil
n = 0

while n += 1
  cache_key = rocks.sort.map { |rock| [rock[0], rock[1], rock[2]] }.hash

  run_cycle(rocks, total_x, total_y)

  break if cache.include?(cache_key)

  cache << cache_key
end

start_of_cyle = cache.index(cache_key) + 1

((1000000000 - start_of_cyle) % (n - start_of_cyle)).times do
  run_cycle(rocks, total_x, total_y)
end

p rocks.select { |rock| rock[2] == 'O' }.map { |rock| total_x - rock[0] }.reduce(:+)
