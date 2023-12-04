monkeys = []

File.readlines('input.txt', chomp: true).each_slice(7).with_index do |line, index|
  items = line[1][18..-1].split(', ').map(&:to_i)
  operator, n = line[2][23..-1].split(' ')
  test = line[3][21..-1].to_i
  if_true = line[4][29..-1].to_i
  if_false = line[5][30..-1].to_i

  monkeys << {
    id: index,
    items: items,
    operator: operator,
    n: n == 'old' ? n : n.to_i,
    test: test,
    if_true: if_true,
    if_false: if_false,
    inspect_count: 0
  }
end

supermodule = monkeys.map { |m| m[:test] }.reduce(:*)

10_000.times do |n|
  monkeys.each do |monkey|
    monkey[:items].each do |item|
      monkey[:inspect_count] += 1

      n = monkey[:n] == 'old' ? item : monkey[:n]
      n = monkey[:operator] == '+' ? (item + n) : (item * n)
      n = n % supermodule

      if n % monkey[:test] == 0
        monkeys[monkey[:if_true]][:items] << n
      else
        monkeys[monkey[:if_false]][:items] << n
      end
    end

    monkey[:items] = []
  end
end

monkey_1, monkey_2 = monkeys.map { |m| m[:inspect_count] }.sort.reverse[0..1]

p monkey_1 * monkey_2
