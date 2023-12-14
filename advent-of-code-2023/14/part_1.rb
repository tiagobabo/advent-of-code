require 'ostruct'

rocks_by_column = {}
total = 0
File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  line.split('').each_with_index do |rock, y|
    next if rock == '.'

    case rock
    when '#'
      rocks_by_column[y] ||= []
      rocks_by_column[y] << OpenStruct.new(x:, y:, rock:)
    when 'O'
      rocks_by_column[y] ||= []
      rock_x = rocks_by_column[y].last ? rocks_by_column[y].last.x + 1 : 0
      rocks_by_column[y] << OpenStruct.new(x: rock_x, y:, rock:)
    end
  end

  total += 1
end

p rocks_by_column.values.flatten.select { |rock| rock.rock == 'O' }.map { |rock| total - rock.x }.reduce(:+)
