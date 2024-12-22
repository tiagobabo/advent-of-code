def next_secret_number(secret)
  result = secret * 64
  secret = result ^ secret
  secret = secret % 16777216

  result = secret / 32
  secret = result ^ secret
  secret = secret % 16777216

  result = secret * 2048
  secret = result ^ secret
  secret = secret % 16777216
end

end_digits_diff = {}
end_digits = {}

File.readlines('input.txt', chomp: true).map(&:to_i).each do |secret|
  initial_secret = secret
  end_digits_diff[initial_secret] = []
  end_digits[initial_secret] = []
  last_end_digit = secret.to_s[-1].to_i

  2_000.times do
    secret = next_secret_number(secret)
    last_digit = secret.to_s[-1].to_i
    end_digits_diff[initial_secret] << last_digit - last_end_digit if last_end_digit
    end_digits[initial_secret] << last_digit
    last_end_digit = last_digit
  end
end

sum_per_sequence = Hash.new(0)

end_digits_diff.each do |initial_secret, digits_diff|
  digits = end_digits[initial_secret]
  sequences = Set.new

  digits_diff.each_cons(4).with_index do |sequence, index|
    next if sequences.include?(sequence)

    sum_per_sequence[sequence] += digits[index + 3]

    sequences << sequence
  end
end

p sum_per_sequence.values.max
