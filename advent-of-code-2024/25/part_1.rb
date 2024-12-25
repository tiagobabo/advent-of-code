max_space = 6
locks = []
keys = []

File.readlines('input.txt', chomp: true).each_slice(8) do |slice|
  config = []
  parsing_lock = true
  slice[0..-1].each_with_index do |line, y|
    parsing_lock = line.start_with?('#') if y == 0
    next if y == 0 && parsing_lock
    next if y == max_space && !parsing_lock

    line.split('').each_with_index do |char, x|
      config[x] ||= 0
      config[x] += 1 if char == '#'
    end
  end

  parsing_lock ? locks << config : keys << config
end

match = 0

locks.each do |lock|
  keys.each do |key|
    if lock.zip(key).map { |l, k| l + k }.all? { |sum| sum < max_space }
      match += 1
    end
  end
end

p match
