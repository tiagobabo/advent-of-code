ORDERING = %w(A K Q J T 9 8 7 6 5 4 3 2).reverse

lines = File.readlines('input.txt', chomp: true).map { |l| l.split(' ') }

lines.sort_by! do |cards, score|
  cards = cards.split('')
  ordering_array = cards.tally.values.sort.reverse

  ordering_array + cards.map.with_index { |c, i| ORDERING.index(c) }
end

p lines.map(&:last).map.with_index(1).inject(0) { |result, (score, i)| result + score.to_i * i }
