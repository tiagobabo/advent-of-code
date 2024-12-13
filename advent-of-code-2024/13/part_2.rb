machines = []
File.readlines('input.txt', chomp: true).each_slice(4) do |a, b, prize, _|
  _, _, ax, ay = a.split(' ')
  ax = Rational(ax.split('+').last.to_i)
  ay = Rational(ay.split('+').last.to_i)

  _, _, bx, by = b.split(' ')
  bx = Rational(bx.split('+').last.to_i)
  by = Rational(by.split('+').last.to_i)

  _, px, py = prize.split(' ')
  px = Rational(px.split('=').last.to_i + 10000000000000)
  py = Rational(py.split('=').last.to_i + 10000000000000)

  machines << [ax, ay, bx, by, px, py]
end

total = 0

machines.each do |ax, ay, bx, by, px, py|
  y = (py-(ay/ax)*px)/(by-(bx*ay)/ax)
  x = (px-bx*y)/ax

  total += x*3 + y if y == y.to_i && x == x.to_i
end

p total.to_i
