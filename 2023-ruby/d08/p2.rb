path, _meh, *node_list = File.readlines(ARGV[0]).map(&:chomp)

path = path.split('')

nodes = {}
node_list.each do |node|
  loc, left, right = node.delete!('()=,').split
  nodes[loc] = { left:, right: }
end

start_locations = nodes.select { |k, _v| k[-1] == 'A' }.keys

locations = start_locations.dup

steps = locations.map do |loc|
  path.cycle.with_index(1) do |step, s|
    loc = nodes[loc][:left] if step == 'L'
    loc = nodes[loc][:right] if step == 'R'
    break s if loc[-1] == 'Z'
  end
end

p steps
p steps.reduce(1, :lcm)
