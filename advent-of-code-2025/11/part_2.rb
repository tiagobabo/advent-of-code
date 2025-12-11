@connections = {}
@cache = {}

File.readlines('input.txt', chomp: true).each do |line|
  source, destinations = line.split(': ')
  @connections[source] = destinations.split(' ')
end

def dfs(current, dac_visited, fft_visited)
  return (dac_visited && fft_visited) ? 1 : 0 if current == 'out'

  @cache[[current, dac_visited, fft_visited]] ||= @connections[current].sum do |destination|
    dfs(destination, dac_visited || destination == 'dac', fft_visited || destination == 'fft')
  end
end

p dfs('svr', false, false)
