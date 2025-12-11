connections = {}
total = 0

File.readlines('input.txt', chomp: true).each do |line|
  source, destinations = line.split(': ')
  connections[source] = destinations.split(' ')
end

queue = ['you']

until queue.empty?
  current = queue.shift

  if current == 'out'
    total += 1
    next
  end

  connections[current].each do |destination|
    queue << destination
  end
end

p total
