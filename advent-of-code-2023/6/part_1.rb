lines = File.readlines('input.txt', chomp: true)
times, max_distances = lines.map {|l| l.scan(/(\d+)/).flatten.map(&:to_i) }
multiplication = 1

times.each_with_index do |time, index|
  multiplication *= (0..time).count { |t| t * (time - t) > max_distances[index] }
end

p multiplication
