lines = File.readlines('input.txt', chomp: true)
times, max_distances = lines.map {|l| l.scan(/(\d+)/).flatten.map(&:to_i) }

result = times.zip(max_distances).inject(1) do |result, (time, max_distance)|
  result * (0..time).count { |t| t * (time - t) > max_distance }
end

p result
