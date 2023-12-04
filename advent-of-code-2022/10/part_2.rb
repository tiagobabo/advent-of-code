register = [0, 1]

File.readlines('input.txt', chomp: true).each do |line|
  if line == 'noop'
    register << register.last
  else
    register << register.last
    register << register.last + line.split(' ').last.to_i
  end
end

(1..240).each_slice(40).with_index do |cycles, i|
  line = cycles.map do |cycle|
    position_to_draw = (cycle - 1) % 40

    if (register[cycle] - 1..register[cycle] + 1).include?(position_to_draw)
      '#'
    else
      '.'
    end
  end

  puts line.join
end
