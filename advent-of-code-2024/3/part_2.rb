total = 0
enabled = true

File.read('input.txt').scan(/mul\((\d{1,3}),(\d{1,3})\)|(don't\(\)|do\(\))/).map do |a, b, do_dont|
  if a && b
    total += (a.to_i * b.to_i) if enabled
  else
    enabled = do_dont == 'do()'
  end
end

p total
