
require 'set'

head_x, head_y = 0, 0
tail_x, tail_y = 0, 0
visited = Set[[tail_x, tail_y]]

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

    tail_x, tail_y = update_tail_position(head_x, head_y, tail_x, tail_y)

    visited.add([tail_x, tail_y])
  end
end

p visited.size
