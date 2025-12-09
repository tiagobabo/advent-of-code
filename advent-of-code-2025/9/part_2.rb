@points = []
@perimeter = Set.new

def area(p1, p2)
  ((p1[0] - p2[0]).abs + 1) * ((p1[1] - p2[1]).abs + 1)
end

def inside_perimeter?(p1, p2)
  min_x, max_x = [p1[0], p2[0]].min, [p1[0], p2[0]].max
  min_y, max_y = [p1[1], p2[1]].min, [p1[1], p2[1]].max

  @perimeter.none? do |x, y|
    min_x < x && x < max_x && min_y < y && y < max_y
  end
end

File.readlines('input.txt', chomp: true).each do |line|
  @points << line.split(',').map(&:to_i)
end

(@points + [@points.first]).each_cons(2) do |(x1, y1), (x2, y2)|
  ([x1, x2].min..[x1, x2].max).each do |x|
    ([y1, y2].min..[y1, y2].max).each do |y|
      @perimeter << [x, y]
    end
  end
end

@points.combination(2).sort_by { |a, b| -area(a, b) }.each do |(x1, y1), (x2, y2)|
  next unless inside_perimeter?([x1, y1], [x2, y2])

  p area([x1, y1], [x2, y2])
  break
end
