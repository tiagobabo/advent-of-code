points = {}

File.readlines('input.txt', chomp: true).each do |line|
  point, velocities = line.split(' @ ')
  x, y, z = point.split(', ')
  x_velocity, y_velocity, z_velocity = velocities.split(', ')
  points[[x.to_i, y.to_i, z.to_i]] = [x_velocity.to_i, y_velocity.to_i, z_velocity.to_i]
end

equations = []
n = 0
points.take(3).each_with_index do |((x, y, z), (x_velocity, y_velocity, z_velocity)), i|
  equations << "eq#{n} = x+w*#{('a'..'z').to_a[i]}==#{x}+#{x_velocity}*#{('a'..'z').to_a[i]}"
  equations << "eq#{n + 1} = y+r*#{('a'..'z').to_a[i]}==#{y}+#{y_velocity}*#{('a'..'z').to_a[i]}"
  equations << "eq#{n + 2} = z+p*#{('a'..'z').to_a[i]}==#{z}+#{z_velocity}*#{('a'..'z').to_a[i]}"
  n += 3
end

equations.each { |equation| puts equation }
puts equations.join(', ')

# Use SageMath to solve the equations:
# var('x,y,z,w,r,p,a,b,c')
# eq0 = x+w*a==197869613734967+150*a
# eq1 = y+r*a==292946034245705+5*a
# eq2 = z+p*a==309220804687650-8*a
# eq3 = x+w*b==344503265587754-69*b
# eq4 = y+r*b==394181872935272+11*b
# eq5 = z+p*b==376338710786779-46*b
# eq6 = x+w*c==293577250654200-17*c
# eq7 = y+r*c==176398758803665+101*c
# eq8 = z+p*c==272206447651388+26*c
# h = solve([eq0,eq1,eq2,eq3,eq4,eq5,eq6,eq7,eq8],[x,y,z,w,r,p,a,b,c])
# h[0]
