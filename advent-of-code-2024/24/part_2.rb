wires = {}
gates = []

File.readlines('input.txt', chomp: true).each do |line|
  next if line.empty?
  if line.include?(':')
    wire, value = line.split(': ')
    wires[wire] = value.to_i
  else
    left, operator, right, _, wire = line.split(' ')

    gates << [left, operator, right, wire]
  end
end

def find_gate(gates, gate_a, gate_b, operator)
  gates.find { |g| g[0] == gate_a && g[1] == operator && g[2] == gate_b } || gates.find { |g| g[0] == gate_b && g[1] == operator && g[2] == gate_a }
end

carry_wire = nil
changed = []

# Implementation of a full adder
# Manually fixed input until this passes
(0..44).each do |i|
  puts ""
  left = i < 10 ? "x0#{i}" : "x#{i}"
  right = i < 10 ? "y0#{i}" : "y#{i}"
  z = i < 10 ? "z0#{i}" : "z#{i}"

  if i == 0
    carry_wire = find_gate(gates, left, right, 'AND').last
    next
  end

  xor_gate = find_gate(gates, left, right, 'XOR')
  puts "XOR:       #{xor_gate}"
  and_gate = find_gate(gates, left, right, 'AND')
  puts "AND:       #{and_gate}"
  carry_xor_gate = find_gate(gates, carry_wire, xor_gate.last, 'XOR')
  puts "Carry XOR: #{carry_xor_gate}"
  carry_and_gate = find_gate(gates, carry_wire, xor_gate.last, 'AND')
  puts "Carry AND: #{carry_and_gate}"
  carry_or_gate = find_gate(gates, carry_and_gate.last, and_gate.last, 'OR')
  puts "Carrry OR: #{carry_or_gate}"
  carry_wire = carry_or_gate.last
  puts "Carry gate: #{carry_wire}"
end
