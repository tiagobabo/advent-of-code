@numeric_keypad = {
  [0, 0] => '7', [1, 0] => '8', [2, 0] => '9',
  [0, 1] => '4', [1, 1] => '5', [2, 1] => '6',
  [0, 2] => '1', [1, 2] => '2', [2, 2] => '3',
  [1, 3] => '0', [2, 3] => 'A'
}

@directional_keypad = {
  [1, 0] => '^', [2, 0] => 'A',
  [0, 1] => '<', [1, 1] => 'v', [2, 1] => '>'
}

@possible_movements = { [1, 0] => '>', [-1, 0] => '<', [0, 1] => 'v', [0, -1] => '^' }

def find_shortest_paths(map, start_pos, target_pos)
  queue = [[start_pos, []]]
  visited = { start_pos => 0 }
  paths = []

  until queue.empty?
    current_pos, path = queue.shift

    if current_pos == target_pos
      paths << path + ['A']

      next
    end

    @possible_movements.each do |(dx, dy), direction|
      next_pos = [current_pos[0] + dx, current_pos[1] + dy]

      next unless map[next_pos]

      new_distance = path.length + 1

      next unless !visited.key?(next_pos) || new_distance <= visited[next_pos]

      visited[next_pos] = new_distance

      queue << [next_pos, path + [direction]]
    end
  end

  paths
end

@cache = {}

def dfs(code, deep, map = @numeric_keypad)
  @cache[[code, deep]] ||= ('A' + code).chars.each_cons(2).map do |a, b|
    paths = find_shortest_paths(map, map.key(a), map.key(b))

    if deep == 0
      paths.map(&:length).min
    else
      paths.map { |path| dfs(path.join, deep - 1, @directional_keypad) }.min
    end
  end.sum
end

codes = File.readlines('input.txt', chomp: true)
total = codes.sum do |code|
  code.to_i * dfs(code, 25)
end

puts total
