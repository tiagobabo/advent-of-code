@register_a = nil
@register_b = nil
@register_c = nil
@output = []
instructions = []

File.readlines('input.txt', chomp: true).each do |line|
  next if line.empty?

  if line.start_with?('Register A:')
    @register_a = line.split(' ').last.to_i
  elsif line.start_with?('Register B:')
    @register_b = line.split(' ').last.to_i
  elsif line.start_with?('Register C:')
    @register_c = line.split(' ').last.to_i
  else
    instructions = line.split(' ').last.split(',').map(&:to_i).each_slice(2).to_a
  end
end

def combo_operand(literal)
  case literal
  when (0..3)
    literal
  when 4
    @register_a
  when 5
    @register_b
  when 6
    @register_c
  end
end

def apply_instruction(instruction, literal, current_instruction)
  next_instruction = current_instruction + 1

  case instruction
  when 0
    @register_a = @register_a / (2 ** combo_operand(literal))
  when 1
    @register_b = @register_b ^ literal
  when 2
    @register_b = combo_operand(literal) % 8
  when 3
    if @register_a != 0
      next_instruction = literal
    end
  when 4
    @register_b = @register_c ^ @register_b
  when 5
    @output << combo_operand(literal) % 8
  when 6
    @register_b = @register_a / (2 ** combo_operand(literal))
  when 7
    @register_c = @register_a / (2 ** combo_operand(literal))
  end

  next_instruction
end

i = 1
instructions_to_compare = instructions.flatten

while true
  @register_a = i
  @output = []

  next_instruction = 0

  while next_instruction < instructions.size
    instruction, literal = instructions[next_instruction]
    next_instruction = apply_instruction(instruction, literal, next_instruction)
  end

  break if @output.size == instructions_to_compare.size && @output == instructions_to_compare

  if @output == instructions_to_compare[-@output.size..]
    i *= 8
  else
    i += 1
  end
end

puts i
