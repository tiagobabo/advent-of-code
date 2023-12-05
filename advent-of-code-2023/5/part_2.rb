seeds = []
lines = File.readlines('input.txt', chomp: true)
_, seeds = lines.first.split(': ')
seeds = seeds.split(' ').map(&:to_i).each_slice(2).map { |seed, range| [(seed...seed + range), false] }

lines[1..].reject { |l| l.empty? }.each do |line|
  seeds.map! { |n, _| [n, false] } && next if line.include?(':')

  new_number, old_number, range = line.split(' ').map(&:to_i)

  seeds.map! do |seed_range, visited|
    old_number_range = (old_number...old_number + range)

    if visited || old_number_range.max < seed_range.begin || seed_range.max < old_number_range.begin
      [seed_range, visited]
    else
      intersection = [old_number_range.begin, seed_range.begin].max..[old_number_range.max, seed_range.max].min

      left_range = seed_range.begin..(intersection.begin - 1)
      right_range = (intersection.end + 1)..seed_range.end

      seeds << [left_range, false] if left_range.size > 0
      seeds << [right_range, false] if right_range.size > 0

      [(new_number + (intersection.begin - old_number)..(new_number + (intersection.end - old_number))), true]
    end
  end
end

p seeds.map(&:first).map(&:begin).min
