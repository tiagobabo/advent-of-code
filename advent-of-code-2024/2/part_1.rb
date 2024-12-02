total = 0

File.readlines('input.txt', chomp: true).each do |line|
  increasing, deacreasing = false, false

  line.split(' ').map(&:to_i).each_cons(2) do |a, b|
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

  total += 1 if increasing ^ deacreasing
end

p total
