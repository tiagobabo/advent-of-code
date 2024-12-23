connections = {}

File.readlines('input.txt', chomp: true).each do |line|
  c1, c2 = line.split('-')
  connections[c1] ||= []
  connections[c1] << c2
  connections[c2] ||= []
  connections[c2] << c1
end

max_clique = []

connections.keys.each do |start_computer|
  current_clique = [start_computer]

  connections[start_computer].each do |computer|
    if current_clique.all? { |node| connections[node].include?(computer) }
      current_clique << computer
    end
  end

  max_clique = current_clique if current_clique.size > max_clique.size
end

puts max_clique.sort.join(',')
