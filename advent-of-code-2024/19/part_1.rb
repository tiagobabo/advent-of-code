available_towels = []
designs = []

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  next if line.empty?

  if i == 0
    available_towels = line.split(', ')
  else
    designs << line
  end
end

total = 0

designs.each do |design|
  queue = [design]

  until queue.empty?
    current_design = queue.min_by(&:length)

    queue.delete(current_design)

    if current_design.empty?
      total += 1
      break
    end

    available_towels.each do |towel|
      next unless current_design.start_with?(towel)

      new_design = current_design[towel.length..-1]

      queue << new_design
    end
  end
end

p total
