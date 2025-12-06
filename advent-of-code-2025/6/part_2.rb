problems = []
lines = File.readlines('input.txt', chomp: true)
total = 0
current_index = 0

lines.each { |line| line << ' ' }
lines.last.scan(/\S\s*/).each_with_index do |operator, index|
  lines[..-2].each do |line|
    problems[index] ||= []
    problems[index] << line[current_index..current_index + operator.size - 2]
  end

  problems[index] << operator.strip

  current_index += operator.size
end

problems.each do |problem|
  operator = problem.pop
  biggest_line = problem.max_by(&:length).length
  numbers = []

  biggest_line.times do |i|
    problem.each do |line|
      numbers[i] ||= ''
      numbers[i] << line[biggest_line - i - 1]
    end
  end

  total += numbers.map(&:to_i).inject(operator == '+' ? :+ : :*)
end

p total
