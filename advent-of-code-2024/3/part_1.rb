p File.read('input.txt').scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { |a, b| a.to_i * b.to_i }.sum
