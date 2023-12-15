def hash_algorithm(value)
  value.each_byte.inject(0) { |sum, char| ((sum + char) * 17) % 256 }
end

File.readlines('input.txt', chomp: true).each do |line|
  result = line.split(',').inject(0) do |sum, step|
    sum + hash_algorithm(step)
  end

  p result
end
