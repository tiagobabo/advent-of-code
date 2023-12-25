initial_edges = []

File.readlines('input.txt', chomp: true).each do |line|
  node, nodes = line.split(': ')
  nodes = nodes.split(' ')

  nodes.each do |child|
    initial_edges << [node, child]
  end
end

# Karger's algorithm
n = 0
until n == 3
  edges = initial_edges.map(&:dup)

  while edges.flatten.uniq.size > 2
    edge = edges.shuffle.pop
    first, second = edge
    new_edge_key = "#{first}-#{second}"
    edges.each do |edge|
      if edge.include?(first) || edge.include?(second)
        edge.delete(first)
        edge.delete(second)
        edge << new_edge_key
      end
    end

    edges.reject! { |edge| edge.size < 2 }
  end

  n = edges.size
end

p edges.first.first.split('-').size * edges.first.last.split('-').size
