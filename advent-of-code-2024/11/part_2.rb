arrangement = {}

File.readlines('input.txt', chomp: true).each do |line|
  line.split(' ').each do |number|
    arrangement[number.to_i] = 1
  end
end

75.times do
  new_arrangement = Hash.new(0)

  arrangement.each do |key, total|
    if key == 0
      new_arrangement[1] += total
    elsif key.to_s.length.even?
      half = key.to_s.length / 2
      first_half = key.to_s[0...half].to_i
      second_half = key.to_s[half..-1].to_i
      new_arrangement[first_half] += total
      new_arrangement[second_half] += total
    else
      new_arrangement[key * 2024] += total
    end
  end

  arrangement = new_arrangement
end

p arrangement.values.sum
