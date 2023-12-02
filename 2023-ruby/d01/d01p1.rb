file = File.open("input")
lines = file.readlines.map(&:chomp)
total = 0
debug = false
lines.each do |line|
  p line if debug
  linesplit = line.split('')
  p linesplit if debug
  digits = linesplit.select { |c| c =~ /[[:digit:]]/ } 
  p digits if debug
  f = digits.first
  l = digits.last
  s = (f + l).to_i
  total += s
  p s
  p "----" if not debug
end
p total