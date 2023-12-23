@nodes = {}
@last_point = nil

File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  line.chars.each_with_index do |char, y|
    if char != '#'
      @nodes[[x, y]] = char
      @last_point = [x, y]
    end
  end
end

@max_distance = 0
@visited = {}

def visit(node, distance)
  return if @visited[node]

  @visited[node] = true

  @max_distance = [@max_distance, distance].max if node == @last_point

  x, y = node

  if @nodes[[x - 1, y]] && (@nodes[[x - 1, y]] == '.' || @nodes[[x - 1, y]] == '^')
    visit([x - 1, y], distance + 1)
  end

  if @nodes[[x + 1, y]] && (@nodes[[x + 1, y]] == '.' || @nodes[[x + 1, y]] == 'v')
    visit([x + 1, y], distance + 1)
  end

  if @nodes[[x, y - 1]] && (@nodes[[x, y - 1]] == '.' || @nodes[[x, y - 1]] == '<')
    visit([x, y - 1], distance + 1)
  end

  if @nodes[[x, y + 1]] && (@nodes[[x, y + 1]] == '.' || @nodes[[x, y + 1]] == '>')
    visit([x, y + 1], distance + 1)
  end

  @visited[node] = false
end

visit([0, 1], 0)

p @max_distance
