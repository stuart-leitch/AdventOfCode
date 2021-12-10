$readings = File.readlines("input").map(&:strip).map!(&:chars)
OPENERS = ["(", "[", "{", "<"]
CLOSERS = [")", "]", "}", ">"]
POINTS = [3, 57, 1197, 25137]

points = []
$readings.each do |line|
  stack = []
  line.each do |c|
    if OPENERS.include? c
      stack.push c
    else
      n = stack.pop()
      if OPENERS.index(n) != CLOSERS.index(c)
        print "got #{c}, expected #{n}\n"
        points << POINTS[CLOSERS.index(c)]
        break
      end
    end
    p stack
  end
end
p points.count
p points.sum
