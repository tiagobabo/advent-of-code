problems = []
total = 0

File.readlines('input.txt', chomp: true).each do |line|
  line.split.each_with_index do |number_or_operator, index|
    problems[index] ||= []
    problems[index] << number_or_operator
  end
end

problems.each do |problem|
  operator = problem.last
  total += problem[..-2].map(&:to_i).inject(operator == '+' ? :+ : :*)
end

p total
