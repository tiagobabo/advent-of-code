repeated_ids = []

File.readlines('input.txt', chomp: true).each do |line|
  ids = line.split(',').map { |id| id.split('-') }
  ids.each do |l, r|
    (l.to_i..r.to_i).each do |i|
      i = i.to_s
      half_point = i.size / 2
      if i[0...half_point] == i[half_point..]
        repeated_ids << i
      end
    end
  end
end

p repeated_ids.map(&:to_i).sum
