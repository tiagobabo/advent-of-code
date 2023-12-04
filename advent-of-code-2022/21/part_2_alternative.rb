left = nil
right = nil

File.readlines('input.txt', chomp: true).each do |line|
  tokens = line.split(' ')
  monkey = tokens[0][0..-2]

  if monkey == 'root'
    left = tokens[1]
    right = tokens[3]
  elsif monkey == 'humn'
    define_method(monkey) { 'x' }
  elsif tokens.size == 2
    define_method(monkey) { tokens[1].to_i }
  else
    define_method(tokens[0][0..-2]) do
      left_result = send(tokens[1])
      right_result = send(tokens[3])

      if left_result.is_a?(Integer) && right_result.is_a?(Integer)
        left_result.send(tokens[2], right_result)
      else
        "(#{left_result} #{tokens[2]} #{right_result})"
      end
    end
  end
end

puts "#{send(left)} = #{send(right)}"
