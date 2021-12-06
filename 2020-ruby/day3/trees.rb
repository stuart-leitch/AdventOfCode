input = "input"
# input = "test_input"

entries = File.readlines(input).map { |line| line.chomp }
p entries
p height = entries.length
p width = entries[0].length

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
track = 1

slopes.each { |s|
  pos_x = 0
  pos_y = 0
  trees = 0
  slope_x, slope_y = s[0], s[1]

  (height - 1).times { |r|
    pos_y += slope_y
    break if pos_y > height
    pos_x += slope_x
    pos_x -= width if pos_x >= width
    pos = entries[pos_y][pos_x]
    trees += 1 if pos == "#"
    # print "#{pos_y}, #{pos_x} : #{pos} (#{trees})\n"
  }
  track *= trees
  print "#{slope_y}, #{slope_x} : #{trees} (#{track})\n"
}
