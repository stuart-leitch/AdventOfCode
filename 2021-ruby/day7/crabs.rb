crabs = File.read("input").split(",").map(&:to_i)
positions = Array.new(crabs.max + 1, 0)

crabs.each do |crab|
  (0..crabs.max).each do |pos|
    move = (crab - pos).abs
    positions[pos] += (move * (move + 1)) / 2
  end
end
print "Minimum fuel is: #{positions.min} at position #{positions.index(positions.min)}\n"
