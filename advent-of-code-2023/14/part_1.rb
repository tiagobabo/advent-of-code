require 'ostruct'

last_rocks_by_colunn = {}
rocks = []
total = 0

File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  line.split('').each_with_index do |rock, y|
    next if rock == '.'

    rock_x = (last_rocks_by_colunn[y] ? last_rocks_by_colunn[y].x + 1 : 0) if rock == 'O'
    last_rocks_by_colunn[y] = OpenStruct.new(x: rock_x || x, y:, rock:)
    rocks << last_rocks_by_colunn[y]
  end

  total += 1
end

p rocks.select { |rock| rock.rock == 'O' }.map { |rock| total - rock.x }.reduce(:+)
