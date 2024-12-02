total = 0

def safe?(numbers)
  increasing, deacreasing = false, false

  numbers.each_cons(2) do |a, b|
    case a - b
    when (1..3)
      increasing = true
    when (-3..-1)
      deacreasing = true
    else
      increasing, deacreasing = false, false
    end

    break unless increasing ^ deacreasing
  end

  increasing ^ deacreasing
end

File.readlines('input.txt', chomp: true).each do |line|
  numbers = line.split(' ').map(&:to_i)

  if safe?(numbers)
    total += 1
  else
    (0..numbers.size - 1).each do |i|
      if safe?(numbers.dup.tap { |n| n.delete_at(i) })
        total += 1

        break
      end
    end
  end
end

p total
