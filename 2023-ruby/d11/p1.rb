# frozen_string_literal: true

universe = File.readlines(ARGV[0]).map(&:chomp).map(&:chars)
width = universe.first.length
height = universe.length

column_count = Array.new(width, 0)
row_count = Array.new(width, 0)

expanded_universe = []
universe.each do |row|
  p row
  expanded_universe << row
  expanded_universe << row if row.count('#').zero?
  row.each_with_index do |cell, c|
    column_count[c] += 1 if cell == '#'
  end
end

more_expanded_universe = []
expanded_universe.each do |row|
  new_row = []
  row.each_with_index do |cell, c|
    new_row << cell
    new_row << '.' if column_count[c].zero?
  end
  more_expanded_universe << new_row
end

p column_count

pp expanded_universe

pp more_expanded_universe

print "Width: #{width} --> #{more_expanded_universe.first.length}\n"
print "Height: #{height} --> #{expanded_universe.length}\n"

galaxies = []
more_expanded_universe.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    next unless cell == '#'

    galaxies << [r, c]
  end
end
pp galaxies
p galaxies.length
total_distance = 0
galaxies.combination(2).each.with_index(1) do |(g1, g2), i|
  distance = (g1[0] - g2[0]).abs + (g1[1] - g2[1]).abs
  total_distance += distance
  print "#{i.to_s.rjust(2, ' ')} : #{g1} --> #{g2} : #{distance}\n"
end
p total_distance
