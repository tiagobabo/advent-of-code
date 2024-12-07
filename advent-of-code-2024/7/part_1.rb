result = 0
operators = [:+, :*]

File.readlines('input.txt', chomp: true).each do |line|
  line_total, values = line.split(': ').then { |line_total, values| [line_total.to_i, values.split(' ').map(&:to_i)] }
  operators_permutations = operators.repeated_permutation(values.size - 1)

  operators_permutations.each do |operators|
    total = values.drop(1).zip(operators).inject(values.first) do |acc, (value, operator)|
      acc.send(operator, value)
    end

    if total == line_total
      result += line_total
      break
    end
  end
end

p result
