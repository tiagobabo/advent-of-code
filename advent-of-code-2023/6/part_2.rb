lines = File.readlines('input.txt', chomp: true)
time, max_distance = lines.map {|l| l.scan(/(\d+)/).flatten.join.to_i }

p (0..time).count { |t| t * (time - t) > max_distance }
