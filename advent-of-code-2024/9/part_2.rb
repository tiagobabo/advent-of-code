filesystem = []

File.readlines('input.txt', chomp: true).each do |line|
  line.split('').each_slice(2).with_index do |(key, value), index|
    filesystem << [index, key.to_i]

    break if value.nil?

    filesystem << [nil, value.to_i]
  end
end

(0..filesystem.last.first).reverse_each do |value|
  current_position = filesystem.rindex { |v, _| v == value }
  current_value, current_count = filesystem[current_position]
  first_free_position = filesystem.find_index { |value, count| value.nil? && count >= current_count }

  next unless first_free_position && first_free_position < current_position

  current_nil_count = filesystem[first_free_position].last

  filesystem[first_free_position] = [current_value, current_count]

  if (diff = current_nil_count - current_count) > 0
    if filesystem[first_free_position + 1] && filesystem[first_free_position + 1].first.nil?
      filesystem[first_free_position + 1] = [nil, filesystem[first_free_position + 1].last + diff]
    elsif filesystem[first_free_position - 1] && filesystem[first_free_position - 1].first.nil?
      filesystem[first_free_position - 1] = [nil, filesystem[first_free_position - 1].last + diff]
    else
      filesystem.insert(first_free_position + 1, [nil, diff])
    end
  end

  current_position = filesystem.rindex { |v, _| v == value }

  if filesystem[current_position + 1] && filesystem[current_position + 1].first.nil?
    filesystem[current_position + 1] = [nil, filesystem[current_position + 1].last + current_count]
    filesystem.delete_at(current_position)
  elsif filesystem[current_position - 1] && filesystem[current_position - 1].first.nil?
    filesystem[current_position - 1] = [nil, filesystem[current_position - 1].last + current_count]
    filesystem.delete_at(current_position)
  else
    filesystem[current_position] = [nil, current_count]
  end
end

index_shift = 0
total = 0

filesystem.each do |value, count|
  if value
    (index_shift...index_shift + count).each do |i|
      total += i * value
    end
  end

  index_shift += count
end

p total
