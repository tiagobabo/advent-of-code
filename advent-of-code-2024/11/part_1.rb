arrangement = []

File.readlines('input.txt', chomp: true).each do |line|
  line.split(' ').each do |number|
    arrangement << number.to_i
  end
end

25.times do
  i = 0

  while arrangement[i]
    if arrangement[i] == 0
      arrangement[i] = 1
      i += 1
    elsif arrangement[i].to_s.length.even?
      half = arrangement[i].to_s.length / 2
      first_half = arrangement[i].to_s[0...half].to_i
      second_half = arrangement[i].to_s[half..-1].to_i
      arrangement[i] = first_half
      arrangement.insert(i + 1, second_half)
      i += 2
    else
      arrangement[i] = arrangement[i] * 2024
      i += 1
    end
  end
end

p arrangement.size
