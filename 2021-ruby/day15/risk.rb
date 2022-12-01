$vals = Array.new(10) { Array.new(10) }

lines = File.readlines("test_input")
lines.each_with_index do |l, i|
  p l.strip.chars.map(&:to_i)
  l.strip.chars.each_with_index { |c, j|
    # print "#{j}, #{i} ==> #{c}\n"
    $vals[j][i] = c.to_i
  }
end

# x, y = 0, 0
$path = ""
# cost = 0

def cost(x, y)
  p $path
  print "#{x}, #{y} ==> #{$vals[x][y]}\n"
  if x == 9 && y == 9
    # if y + 1 == $vals.count && x + 1 == $vals[0].count
    cost = $vals[x][y]
  elsif y + 1 == $vals.count
    $path += "R"
    right = $vals[x + 1][y]
    cost = right + cost(x + 1, y)
  elsif x + 1 == $vals[0].count
    $path += "D"
    down = $vals[x][y + 1]
    cost = down + cost(x, y + 1)
  else
    down = $vals[x][y + 1]
    right = $vals[x + 1][y]
    if down < right
      $path += "D"
      cost = down + cost(x, y + 1)
    else
      $path += "R"
      cost = right + cost(x + 1, y)
    end
  end
  return cost
end

cst = cost(0, 0)
p $path
p cst
