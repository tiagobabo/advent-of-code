result = File.readlines('input.txt', chomp: true).each.inject(0) do |acc, line|
  steps = [line.split(' ').map(&:to_i)]

  until steps.last.all?(&:zero?)
    steps << steps.last.each_cons(2).map { |a, b| b - a }
  end

  acc + steps.reverse.inject(0) { |acc, steps| steps.first - acc }
end

p result
