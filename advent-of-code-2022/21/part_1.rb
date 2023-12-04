File.readlines('input.txt', chomp: true).each do |line|
  tokens = line.split(' ')

  if tokens.size == 2
    define_method(tokens[0][0..-2]) { tokens[1].to_i }
  else
    define_method(tokens[0][0..-2]) { send(tokens[1]).send(tokens[2], send(tokens[3])) }
  end
end

p root
