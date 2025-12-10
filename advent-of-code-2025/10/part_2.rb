require 'ruby-cbc'

joltage_levels_with_instructions = []
total = 0

File.readlines('input.txt', chomp: true).each do |line|
  current_joltage, current_instructions = nil, []
  line.split(' ').each do |instructions|
    if instructions.start_with?('{')
      current_joltage = instructions[1..-2].split(',').map(&:to_i)
    elsif instructions.start_with?('(')
      current_instructions << instructions[1..-2].split(',').map(&:to_i)
    end
  end
  joltage_levels_with_instructions << [current_joltage, current_instructions]
end

joltage_levels_with_instructions.each do |joltage_level, instructions|
  intructions_by_joltage_level_index = Hash.new { |hash, key| hash[key] = [] }

  joltage_level.each_with_index do |joltage, joltage_index|
    instructions.each_with_index do |instruction, instruction_index|
      intructions_by_joltage_level_index[joltage_index] << instruction_index if instruction.include?(joltage_index)
    end
  end

  m = Cbc::Model.new
  instructions_variables = m.int_var_array(instructions.size, 0..Cbc::INF)

  intructions_by_joltage_level_index.each do |joltage_index, instruction_indexes|
    sum = instruction_indexes.sum { |i| instructions_variables[i] }
    m.enforce(sum == joltage_level[joltage_index])
  end

  m.minimize(instructions_variables.sum)
  problem = m.to_problem

  problem.solve

  total += problem.objective_value.to_i
end

p total
