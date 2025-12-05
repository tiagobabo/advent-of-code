ranges = []

File.readlines('input.txt', chomp: true).each do |line|
  next unless line.include?('-')
  first, second = line.split('-')
  ranges << (first.to_i..second.to_i)
end

merge_overlapping_ranges = true

while merge_overlapping_ranges
  merge_overlapping_ranges = false

  ranges.each do |range|
    ranges.each do |other_range|
      next unless range != other_range && range.overlap?(other_range)

      merge_overlapping_ranges = true
      min = [range.first, other_range.first].min
      max = [range.last, other_range.last].max

      ranges.delete(range)
      ranges.delete(other_range)
      ranges << (min..max)

      break
    end

    break if merge_overlapping_ranges
  end
end

p ranges.uniq.map(&:size).sum
