total = 0
dependencies = Hash.new { |hash, key| hash[key] = Set.new }
updates = []

first_part, second_part = File.read('input.txt', chomp: true).split("\n\n")
first_part.split("\n").each do |line|
  key, value = line.split('|').map(&:to_i)
  dependencies[key] << value
end
second_part.split("\n").each { |line| updates << line.split(',').map(&:to_i) }

updates.each do |update|
  valid = update.each_with_index.all? do |value, index|
    next true unless dependencies.key?(value)

    Set.new(update[0...index]).intersection(dependencies[value]).empty?
  end

  next unless valid

  total += update[update.size / 2].to_i
end

p total
