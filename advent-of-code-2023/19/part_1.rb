parsing_workflows = true
workflows = {}
ratings = []

File.readlines('input.txt', chomp: true).each do |line|
  if line.empty?
    parsing_workflows = false
    next
  end

  if parsing_workflows
    workflow, instructions, default_destination = line.scan(/(\w+){(.+),([a-zA-Z]+)}/).first
    instructions = instructions.split(',').map do |instruction|
      part, operator, value, destination = instruction.scan(/(\w+)(<|>)(\d+):(\w+)/).first
      { part: part, operator: operator, value: value.to_i, destination: destination }
    end

    workflows[workflow] = { instructions: instructions, default_destination: default_destination }
  else
    parts = line.scan(/(\w+)=(\d+)/).map do |part, value|
      [part, value.to_i]
    end

    ratings << parts.to_h
  end
end

START_WORKFLOW = 'in'

result = ratings.inject(0) do |sum, rating|
  next_workflow = START_WORKFLOW

  until ['A', 'R'].include?(next_workflow) do
    workflow = workflows[next_workflow]
    matched_instruction = workflow[:instructions].select { |i| rating.key?(i[:part]) }.find do |instruction|
      rating[instruction[:part]].send(instruction[:operator], instruction[:value])
    end

    next_workflow = matched_instruction ? matched_instruction[:destination] : workflow[:default_destination]
  end

  if next_workflow == 'A'
    sum + rating.values.sum
  else
    sum
  end
end

p result
