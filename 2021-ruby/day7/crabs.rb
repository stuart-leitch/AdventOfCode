input = "input"
# input = "test_input"

crabl = File.readlines(input)
crabl.each do |crabs|
  # crabs.to_a
  # ca = Array.new(crabs)
  ca = crabs.split(",").map(&:to_i)
  p ca
  p ca.min
  p ca.max
  poss = Array.new(ca.max + 1, 0)
  ca.each do |c|
    (ca.min..ca.max).each do |pos|
      move = (c - pos).abs
      cost = (move * (move + 1)) / 2
      poss[pos] += cost
    end
  end
  p poss
  p poss.min
  p poss.index(poss.min)
  #  do |crab|
  #   print "#{crab}\n"
  # end
end
