map = File.readlines('input.txt', chomp: true).map { |line| line.split('') }
s = map.each_with_index.map { |row, i| [i, row.index('S')] }.reject { |row| row[1].nil? }.first

paths = []
paths << [[s[0] - 1, s[1]]] if %w(| F 7).include?(map[s[0] - 1][s[1]])
paths << [[s[0] + 1, s[1]]] if %w(| L J).include?(map[s[0] + 1][s[1]])
paths << [[s[0], s[1] - 1]] if %w(- F L).include?(map[s[0]][s[1] - 1])
paths << [[s[0], s[1] + 1]] if %w(- J 7).include?(map[s[0]][s[1] + 1])
paths.each { |p| p.unshift(s) }

until paths.first.last == paths.last.last
  paths.each do |path|
    previous, current = path.last(2)

    case map[current[0]][current[1]]
    when '|'
      previous[0] > current[0] ?  path << [current[0] - 1, current[1]] : path << [current[0] + 1, current[1]]
    when '-'
      previous[1] > current[1] ?  path << [current[0], current[1] - 1] : path << [current[0], current[1] + 1]
    when 'L'
      previous[0] == current[0] ? path << [current[0] - 1, current[1]] : path << [current[0], current[1] + 1]
    when 'J'
      previous[0] == current[0] ? path << [current[0] - 1, current[1]] : path << [current[0], current[1] - 1]
    when '7'
      previous[0] == current[0] ? path << [current[0] + 1, current[1]] : path << [current[0], current[1] - 1]
    when 'F'
      previous[0] == current[0] ? path << [current[0] + 1, current[1]] : path << [current[0], current[1] + 1]
    end
  end
end

p paths.first.size - 1
