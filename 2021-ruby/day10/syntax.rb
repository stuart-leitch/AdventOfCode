$readings = File.readlines("test_input").map(&:strip).map!(&:chars)
OPENERS = ["(", "[", "{", "<"]
CLOSERS = [")", "]", "}", ">"]
POINTS = [3, 57, 1197, 25137]
POINTS2 = [1, 2, 3, 4]

rpoints = []
aps = 0
$readings.each_with_index do |line, row_num|
  status = ""
  points = []
  stack = []
  line.each do |symbol|
    if OPENERS.include? symbol
      stack.push symbol
      # print "+"
    else
      n = stack.pop()
      if OPENERS.index(n) != CLOSERS.index(symbol)
        status = "CORRUPT"
        points << POINTS[CLOSERS.index(symbol)]
        break
      else
        # print "-"
      end
    end
  end
  if status == "CORRUPT"
    print "#{row_num}: #{status} #{line.join.strip} #{points.sum}\n"
    rpoints << points.sum
    next
  end

  if stack.length == 0
    print "happy\n"
  else
    status = "INCOMPLETE {#{stack.join}}"
    ap = []
    while stack.length > 0
      z = stack.pop()
      # cl = CLOSERS[OPENERS.index(z)]
      ct = POINTS2[OPENERS.index(z)]
      ap << ct
    end
    acc = 0
    acc = ap.reduce(0) { |acc, el| ((5 * acc) + el.to_i) }
    aps = acc
  end
  print "#{row_num}: #{status} #{line.join.strip} #{aps}\n"
end
print "#{rpoints.count},  #{rpoints.sum}\n"
