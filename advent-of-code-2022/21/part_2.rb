left = nil
right = nil
left_boundary = 0
right_boundary = 10**14

File.readlines('input.txt', chomp: true).each do |line|
  tokens = line.split(' ')
  monkey = tokens[0][0..-2]

  if monkey == 'root'
    left = tokens[1]
    right = tokens[3]
  elsif monkey == 'humn'
    define_method(monkey) { (left_boundary + right_boundary) / 2.0 }
  elsif tokens.size == 2
    define_method(monkey) { tokens[1].to_i }
  else
    define_method(tokens[0][0..-2]) { send(tokens[1]).send(tokens[2], send(tokens[3])) }
  end
end

while send(right) != send(left)
  send(left) < send(right) ? right_boundary = humn : left_boundary = humn
end

p humn.to_i
