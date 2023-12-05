seeds = []
lines = File.readlines('input.txt', chomp: true)
_, seeds = lines.first.split(': ')
seeds = seeds.split(' ').map(&:to_i).map { |n| [n, false] }

lines[1..].reject { |l| l.empty? }.each do |line|
  seeds.map! { |n, _| [n, false] } && next if line.include?(':')

  new_number, old_number, range = line.split(' ').map(&:to_i)

  seeds.map! do |seed, visited|
    if !visited && seed >= old_number && seed <= old_number + range
      [new_number + (seed - old_number), true]
    else
      [seed, visited]
    end
  end
end

p seeds.map(&:first).min
