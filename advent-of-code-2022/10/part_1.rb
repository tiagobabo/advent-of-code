register = [0, 1]
cycles = [20, 60, 100, 140, 180, 220]

File.readlines('input.txt', chomp: true).each do |line|
  if line == 'noop'
    register << register.last
  else
    register << register.last
    register << register.last + line.split(' ').last.to_i
  end
end

p cycles.map { |cycle| register[cycle] * cycle }.sum
