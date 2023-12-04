numbers = []

MAPPING = { '=' => -2, '-' => -1, '0' => 0, '1' => 1, '2' => 2 }
MAPPING_REVERSE = { -2 => '=', -1 => '-', 0 => '0', 1 => '1', 2 => '2' }

def calc(a, b, carry)
  value = a.to_i + b.to_i + carry
  if value >= -2 && value <= 2
    [value, 0]
  elsif value == 3
    [-2, 1]
  elsif value == 4
    [-1, 1]
  elsif value == -3
    [2, -1]
  elsif value == -4
    [1, -1]
  elsif value == -5
    [0, -1]
  elsif value == 5
    [0, 1]
  end
end

sum = File.readlines('input.txt', chomp: true).inject('') do |left, right|
  left = left.split('').reverse.map { |n| MAPPING[n] }
  right = right.split('').reverse.map { |n| MAPPING[n] }

  first, second = left.size > right.size ? [left, right] : [right, left]

  carry = 0
  v = first.map.with_index { |digit, i| n, carry = calc(digit, second[i], carry); n }.reverse.inject('') do |left, right|
    left << MAPPING_REVERSE[right]
  end

  carry != 0 ? carry.to_s + v : v
end

p sum
