repeated_ids = []

File.readlines('input.txt', chomp: true).each do |line|
  ids = line.split(',').map { |id| id.split('-') }
  ids.each do |l, r|
    (l.to_i..r.to_i).each do |i|
      chars = i.to_s.chars
      (1...chars.size).each do |j|
        if chars.each_slice(j).uniq.size == 1
          repeated_ids << i
          break
        end
      end
    end
  end
end

p repeated_ids.map(&:to_i).sum
