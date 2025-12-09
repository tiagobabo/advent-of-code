@points = []
@cache = {}

def area(p1, p2)
  ((p1[0] - p2[0]).abs + 1) * ((p1[1] - p2[1]).abs + 1)
end

def point_in_points_polygon?(point)
  @cache[point] ||= begin
    x, y = point
    @edges.count do |(x1, y1), (x2, y2)|
      next false if y1 == y2
      ((y1 > y) != (y2 > y)) && x < (x2 - x1) * (y - y1).to_f / (y2 - y1) + x1
    end.odd?
  end
end

File.readlines('input.txt', chomp: true).each do |line|
  @points << line.split(',').map(&:to_i)
end

@edges = @points.each_cons(2).to_a + [[@points.last, @points.first]]

@points.combination(2).sort_by { |a, b| -area(a, b) }.each do |(x1, y1), (x2, y2)|
  x3, y3 = x1, y2
  x4, y4 = x2, y1

  next unless point_in_points_polygon?([x3, y3]) && point_in_points_polygon?([x4, y4])

  range_1 = x1 > x2 ? (x2..x1) : (x1..x2)
  range_2 = y1 > y2 ? (y2..y1) : (y1..y2)
  range_3 = x2 > x1 ? (x1..x2) : (x2..x1)
  range_4 = y2 > y1 ? (y1..y2) : (y2..y1)

  if range_1.all? { |x| point_in_points_polygon?([x, y1]) } &&
     range_2.all? { |y| point_in_points_polygon?([x2, y]) } &&
     range_3.all? { |x| point_in_points_polygon?([x, y2]) } &&
     range_4.all? { |y| point_in_points_polygon?([x1, y]) }
    p area([x1, y1], [x2, y2])
    break
  end
end
