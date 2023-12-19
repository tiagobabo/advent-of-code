@workflows = {}

File.readlines('input.txt', chomp: true).each do |line|
  break if line.empty?

  workflow, instructions, default_destination = line.scan(/(\w+){(.+),([a-zA-Z]+)}/).first
  instructions = instructions.split(',').map do |instruction|
    part, operator, value, destination = instruction.scan(/(\w+)(<|>)(\d+):(\w+)/).first
    { part: part, operator: operator, value: value.to_i, destination: destination }
  end

  @workflows[workflow] = { instructions: instructions, default_destination: default_destination }
end

START_WORKFLOW = 'in'

@total = 0

def find_combinations(current_workflow, max_values)
  max_values = max_values.dup

  @total += max_values.values.map(&:size).reduce(:*) if current_workflow == 'A'

  return if current_workflow == 'A' || current_workflow == 'R'

  @workflows[current_workflow][:instructions].each do |i|
    original_value = max_values[i[:part]]

    if i[:operator] == '<' && original_value.include?(i[:value])
      max_values[i[:part]] = (original_value.min..i[:value] - 1)
      find_combinations(i[:destination], max_values)
      max_values[i[:part]] = (i[:value]..original_value.max)
    elsif i[:operator] == '>' && original_value.include?(i[:value])
      max_values[i[:part]] = (i[:value] + 1..original_value.max)
      find_combinations(i[:destination], max_values)
      max_values[i[:part]] = (original_value.min..i[:value])
    end
  end

  find_combinations(@workflows[current_workflow][:default_destination], max_values)
end

find_combinations(START_WORKFLOW, { 'x' => (1..4000), 'm' => (1..4000), 'a' => (1..4000), 's' => (1..4000) })

p @total

