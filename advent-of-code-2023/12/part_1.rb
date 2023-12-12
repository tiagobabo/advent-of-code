result = File.readlines('input.txt', chomp: true).each.inject(0) do |acc, line|
  springs, valid_permutations = line.split(' ')
  valid_permutations = valid_permutations.split(',').map(&:to_i)

  ['.','#'].repeated_permutation(springs.count('?')).each.inject(acc) do |acc, permutation|
    new_springs = springs.dup

    permutation.each_with_index do |value, i|
      new_springs.sub!('?', value)
    end

    new_springs.scan(/(#+)/).flatten.map(&:size) == valid_permutations ? acc + 1 : acc
  end
end

p result
