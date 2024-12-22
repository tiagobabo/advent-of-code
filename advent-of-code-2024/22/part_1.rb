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

total = File.readlines('input.txt', chomp: true).map(&:to_i).sum do |secret|
  2_000.times { secret = next_secret_number(secret) }
  secret
end

puts total
