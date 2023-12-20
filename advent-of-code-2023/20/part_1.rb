modules = {}
conjunction_module_inputs = {}

Mod = Struct.new(:type, :name, :destinations, :pulse)

File.readlines('input.txt', chomp: true).each do |line|
  module_spec, destinations = line.split(' -> ')
  destinations = destinations.split(', ')
  mod = if module_spec == 'broadcaster'
    Mod.new(:broadcaster, 'broadcaster', destinations, nil)
  elsif module_spec[0] == '%'
    Mod.new(:flip_flop, module_spec[1..-1], destinations, false)
  else
    Mod.new(:conjunction, module_spec[1..-1], destinations, false)
  end

  modules[mod.name] = mod
end

modules.select { |_, mod| mod.type == :conjunction }.each do |name, mod|
  modules.select { |_, mod| mod.destinations.include?(name) }.each do |_, flip_flop|
    conjunction_module_inputs[name] ||= []
    conjunction_module_inputs[name] << flip_flop
  end
end

counts = Hash.new(0)

1000.times do
  queue = [['broadcaster', false]]

  until queue.empty?
    mod, pulse = queue.shift
    mod = modules[mod]

    counts[pulse] += 1

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
      mod.destinations.each do |dest|
        queue << [dest, pulse]
      end
    end
  end
end

p counts.values.reduce(:*)
