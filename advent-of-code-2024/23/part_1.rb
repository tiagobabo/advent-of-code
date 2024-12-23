connections = {}
seen = Set.new

File.readlines('input.txt', chomp: true).each do |line|
  c1, c2 = line.split('-')
  connections[c1] ||= []
  connections[c1] << c2
  connections[c2] ||= []
  connections[c2] << c1
end

total = connections.keys.sum do |c1|
  connections[c1].permutation(2).count do |c2, c3|
    next if seen.include?([c1, c2, c3].to_set)

    seen << [c1, c2, c3].to_set

    [c1, c2, c3].any? { |c| c.start_with?('t') } && connections[c2].include?(c3)
  end
end

p total
