ORDERING = %w(A K Q T 9 8 7 6 5 4 3 2 J).reverse

lines = File.readlines('input.txt', chomp: true).map { |l| l.split(' ') }

lines.sort_by! do |cards, score|
  cards = cards.split('')
  jokers_count = cards.count('J')
  ordering_array = cards.reject { |k| k == 'J' }.tally.values.sort.reverse
  ordering_array[0] ||= 0
  ordering_array[0] += jokers_count

  ordering_array + cards.map.with_index { |c, i| ORDERING.index(c) }
end

p lines.map(&:last).map.with_index(1).inject(0) { |result, (score, i)| result + score.to_i * i }
