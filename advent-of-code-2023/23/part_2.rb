@nodes = {}
@last_point = nil

File.readlines('input.txt', chomp: true).each_with_index do |line, x|
  line.chars.each_with_index do |char, y|
    if char != '#'
      @nodes[[x, y]] = [x, y]
      @last_point = [x, y]
    end
  end
end

def get_vertices(node)
  [].tap do |vertices|
    x, y = node

    vertices << [x + 1, y] if @nodes[[x + 1, y]]
    vertices << [x - 1, y] if @nodes[[x - 1, y]]
    vertices << [x, y + 1] if @nodes[[x, y + 1]]
    vertices << [x, y - 1] if @nodes[[x, y - 1]]
  end
end

def expand_node(node, distance, visited)
  vertices = get_vertices(node).reject { |v| visited.include?(v) }

  if vertices.size == 1
    expand_node(vertices.first, distance + 1, visited + [node])
  else
    [node, distance]
  end
end

@graph = {}

intersections = @nodes.keys.select { |node| get_vertices(node).size > 2 }
intersections.each do |intersection|
  intersection_vertices = get_vertices(intersection)
  intersection_vertices.each do |intersection_vertex|
    final_node, distance = expand_node(intersection_vertex, 0, [intersection])
    @graph[intersection] ||= {}
    @graph[intersection][final_node] = distance + 1
    @graph[final_node] ||= {}
    @graph[final_node][intersection] = distance + 1
  end
end

@max_distance = 0
@visited = {}

def visit(node, distance)
  return if @visited[node]

  @visited[node] = true

  if node == @last_point
    @max_distance = distance if @max_distance < distance
  else
    @graph[node].each do |b, weight|
      visit(b, distance + weight)
    end
  end

  @visited[node] = false
end

visit([0, 1], 0)

p @max_distance
