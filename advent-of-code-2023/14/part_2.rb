require 'ostruct'

def run_cycle(rocks, total_x, total_y)
  ['N', 'W', 'S', 'E'].each do |direction|
    case direction
    when 'N'
      rocks.select { |r| r[2] == 'O' }.sort_by { |r| r[0] }.each do |rock|
        blocking_rock = rocks.select { |r| r[1] == rock[1] && r[0] < rock[0] }.max_by { |r| r[0] }
        rock[0] = blocking_rock ? blocking_rock[0] + 1 : 0
      end
    when 'S'
      rocks.select { |r| r[2] == 'O' }.sort_by { |r| -r[0] }.each do |rock|
        blocking_rock = rocks.select { |r| r[1] == rock[1] && r[0] > rock[0] }.min_by { |r| r[0] }
        rock[0] = blocking_rock ? blocking_rock[0] - 1 : (total_x - 1)
      end
    when 'W'
      rocks.select { |r| r[2] == 'O' }.sort_by { |r| r[1] }.each do |rock|
        blocking_rock = rocks.select { |r| r[0] == rock[0] && r[1] < rock[1] }.max_by { |r| r[1] }
        rock[1] = blocking_rock ? blocking_rock[1] + 1 : 0
      end
    when 'E'
      rocks.select { |r| r[2] == 'O' }.sort_by { |r| -r[1] }.each do |rock|
        blocking_rock = rocks.select { |r| r[0] == rock[0] && r[1] > rock[1] }.min_by { |r| r[1] }
        rock[1] = blocking_rock ? blocking_rock[1] - 1 : (total_y - 1)
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

  total_y = line.length
  total_x += 1
end

cache = []
cache_key = nil
n = 0

while true
  n += 1
  cache_key = rocks.map { |rock| [rock[0], rock[1], rock[2]] }.sort.hash

  run_cycle(rocks, total_x, total_y)

  break if cache.include?(cache_key)

  cache << cache_key
end

start_of_cyle = cache.index(cache_key) + 1

((1000000000 - start_of_cyle) % (n - start_of_cyle)).times do
  run_cycle(rocks, total_x, total_y)
end

p rocks.select { |rock| rock[2] == 'O' }.map { |rock| total_x - rock[0] }.reduce(:+)
