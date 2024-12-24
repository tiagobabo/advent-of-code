wires = {}
gates = []

File.readlines('input.txt', chomp: true).each do |line|
  next if line.empty?
  if line.include?(':')
    wire, value = line.split(': ')
    wires[wire] = value.to_i
  else
    left, operator, right, _, destination = line.split(' ')
    gates << [left, operator, right, destination]
  end
end

until gates.empty?
  left, operator, right, destination = gates.shift

  if wires[left].nil? || wires[right].nil?
    gates << [left, operator, right, destination]
    next
  end

  case operator
  when 'AND'
    wires[destination] = wires[left] & wires[right]
  when 'OR'
    wires[destination] = wires[left] | wires[right]
  when 'XOR'
    wires[destination] = wires[left] ^ wires[right]
  end
end

puts wires.select { |k, _| k.start_with?('z') }.to_a.sort_by(&:first).map(&:last).reverse.join.to_i(2)
