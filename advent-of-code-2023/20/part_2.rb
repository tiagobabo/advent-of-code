modules = {}
conjunction_module_inputs = {}

Mod = Struct.new(:type, :name, :destinations, :pulse)

File.readlines('input.txt', chomp: true).each do |line|
  module_spec, destinations = line.split(' -> ')
  destinations = destinations.split(', ')
  mod = if module_spec == 'broadcaster'
    Mod.new(:broadcaster, 'broadcaster', destinations, false)
  elsif module_spec[0] == '%'
    Mod.new(:flip_flop, module_spec[1..-1], destinations, false)
  else
    Mod.new(:conjunction, module_spec[1..-1], destinations, false)
  end

  destinations.each do |dest|
    puts [mod.name, dest].join(' ')
  end

  modules[mod.name] = mod
end

modules.select { |_, mod| mod.type == :conjunction }.each do |name, mod|
  modules.select { |_, mod| mod.destinations.include?(name) }.each do |_, flip_flop|
    conjunction_module_inputs[name] ||= []
    conjunction_module_inputs[name] << flip_flop
  end
end

count = 0
# This only works on my input because the module before rx (mf) is a conjunction and
# all of its inputs are conjunctions too. It also assumes the first time they emit a
# high pulse is exactly after their entire cycle has been completely iterated through.
end_conjunction_node = 'mf'
nodes_to_inspect_for_cycles = conjunction_module_inputs[end_conjunction_node].map(&:name)
cycles = {}

while true do
  queue = [['broadcaster', false]]
  count += 1

  break if cycles.size == nodes_to_inspect_for_cycles.size

  until queue.empty?
    mod, pulse = queue.shift
    mod = modules[mod]

    next unless mod

    if mod.type == :broadcaster
      mod.destinations.each do |dest|
        queue << [dest, pulse]
      end
    elsif mod.type == :flip_flop
      next if pulse

      mod.pulse = !mod.pulse

      mod.destinations.each do |dest|
        queue << [dest, mod.pulse]
      end
    elsif mod.type == :conjunction
      pulse = !conjunction_module_inputs[mod.name].all?(&:pulse)
      mod.pulse = pulse

      if pulse && nodes_to_inspect_for_cycles.include?(mod.name)
        cycles[mod.name] = count
      end

      mod.destinations.each do |dest|
        queue << [dest, pulse]
      end
    end
  end
end

p cycles.values.reduce(1, :lcm)
