steps_hash = {}

def hash_algorithm(value)
  value.each_byte.inject(0) { |sum, char| ((sum + char) * 17) % 256 }
end

File.readlines('input.txt', chomp: true).each do |line|
  line.split(',').each do |step|
    key = step[/(\w+)/]
    hash_key = hash_algorithm(key)
    steps_hash[hash_key] ||= {}

    if step[-1] == '-'
      steps_hash[hash_key].delete(key)
    else
      steps_hash[hash_key][key] = step[-1].to_i
    end
  end
end

result = steps_hash.inject(0) do |sum, (box_index, value)|
  sum + value.values.each_with_index.inject(0) do |sum, (value, step_index)|
    sum + (box_index + 1) * (step_index + 1) * value
  end
end

p result
