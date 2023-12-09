path, _meh, *node_list = File.readlines(ARGV[0]).map(&:chomp)

path = path.split('')
p path

nodes = {}
node_list.each do |node|
  loc, left, right = node.delete!('()=,').split
  nodes[loc] = { left:, right: }
  # print "loc: #{loc}, left: #{left}, right: #{right}\n"
end
p nodes

steps = 0
loc = 'AAA'
path.cycle do |step|
  print "#{loc} (#{step}) -> "
  loc = nodes[loc][:left] if step == 'L'
  loc = nodes[loc][:right] if step == 'R'
  p loc
  steps += 1
  break if loc == 'ZZZ'
end

p loc
p steps
