machines = []
File.readlines('input.txt', chomp: true).each_slice(4) do |a, b, prize, _|
  _, _, ax, ay = a.split(' ')
  ax = ax.split('+').last.to_i
  ay = ay.split('+').last.to_i

  _, _, bx, by = b.split(' ')
  bx = bx.split('+').last.to_i
  by = by.split('+').last.to_i

  _, px, py = prize.split(' ')
  px = px.split('=').last.to_i
  py = py.split('=').last.to_i

  machines << [ax, ay, bx, by, px, py]
end

total = 0

machines.each do |ax, ay, bx, by, px, py|
  queue = [[0, 0, 0, 0]]
  visited = Set.new
  min_cost = Float::INFINITY

  until queue.empty?
    first = queue.shift
    current_a_presses, current_b_presses, current_x, current_y = first

    next if visited.include?(first)

    visited.add(first)

    next if current_x > px || current_y > py

    if current_x == px && current_y == py
      cost = current_a_presses * 3 + current_b_presses
      min_cost = [min_cost, cost].min
      next
    end

    queue << [current_a_presses + 1, current_b_presses, current_x + ax, current_y + ay]
    queue << [current_a_presses, current_b_presses + 1, current_x + bx, current_y + by]
  end

  total += min_cost unless min_cost == Float::INFINITY
end

p total
