
require 'set'

head_x, head_y = 0, 0
knots = (1..9).map { [0, 0] }
visited = Set[[0, 0]]

def update_tail_position(head_x, head_y, tail_x, tail_y)
  return tail_x, tail_y if (head_x - tail_x).abs <= 1 && (head_y - tail_y).abs <= 1

  tail_x += head_x > tail_x ? 1 : -1 if head_x != tail_x
  tail_y += head_y > tail_y ? 1 : -1 if head_y != tail_y

  return tail_x, tail_y
end

File.readlines('input.txt', chomp: true).each do |line|
  command, n = line.split(' ')

  n.to_i.times do |n|
    case command
    when 'R'
      head_x += 1
    when 'L'
      head_x -= 1
    when 'U'
      head_y += 1
    when 'D'
      head_y -= 1
    end

    previous_x, previous_y = head_x, head_y

    knots.map! do |x, y|
      update_tail_position(previous_x, previous_y, x, y).tap do |x, y|
        previous_x, previous_y = x, y
      end
    end

    visited.add(knots.last)
  end
end

p visited.size
