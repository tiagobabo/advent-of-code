@available_towels = []
designs = []

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  next if line.empty?

  if i == 0
    @available_towels = line.split(', ')
  else
    designs << line
  end
end

@cache = {}

def find_solutions(design)
  return 1 if design.empty?

  @cache[design] ||= @available_towels.sum do |towel|
    next 0 unless design.start_with?(towel)

    new_design = design[towel.length..-1]

    find_solutions(new_design)
  end
end

p designs.sum { |design| find_solutions(design) }
