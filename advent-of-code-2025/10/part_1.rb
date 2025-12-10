machines = []
total = 0

File.readlines('input.txt', chomp: true).each do |line|
  current_machine, current_instructions = nil, []
  line.split(' ').each do |instructions|
    if instructions.start_with?('[')
      current_machine = instructions[1..-2].each_char.map { |char| char == '.' ? 0 : 1 }
    elsif instructions.start_with?('(')
      current_instructions << instructions[1..-2].split(',').map(&:to_i)
    end
  end
  machines << [current_machine, current_instructions]
end

machines.each do |machine, instructions|
  queue = [[Array.new(machine.size, 0), 0]]
  visited = Set.new

  until queue.empty?
    current_state, step = queue.shift

    next if visited.include?([current_state, step])

    visited.add([current_state, step])

    if current_state == machine
      total += step
      break
    end

    instructions.each do |instruction|
      new_state = current_state.dup

      instruction.each do |index|
        new_state[index] = new_state[index] == 0 ? 1 : 0
      end

      queue << [new_state, step + 1]
    end
  end
end

p total
