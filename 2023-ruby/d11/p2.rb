# frozen_string_literal: true

universe = File.readlines(ARGV[0]).map(&:chomp).map(&:chars)

galaxies = []
universe.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    next unless cell == '#'

    galaxies << [r, c]
  end
end
pp galaxies

column_count = Array.new(universe.first.length, 0)
row_count = Array.new(universe.length, 0)
universe.each_with_index do |row, r|
  p row
  row_count[r] = row.count('#')
  row.each_with_index do |cell, c|
    column_count[c] += 1 if cell == '#'
  end
end
p column_count
p row_count

expansion = 1_000_000
rt = 0
expanded_columns = column_count.map.with_index do |count, _i|
  rt += 1 if count.zero?
  # print "#{i} : #{count}\n"
  rt * (expansion - 1)
end
pp expanded_columns
rt = 0
expanded_rows = row_count.map.with_index do |count, _i|
  rt += 1 if count.zero?
  # print "#{i} : #{count}\n"
  rt * (expansion - 1)
end
pp expanded_rows

expanded_galaxies = galaxies.map do |galaxy|
  ng = [galaxy[0] + expanded_rows[galaxy[0]], galaxy[1] + expanded_columns[galaxy[1]]]
  print "#{galaxy} --> #{expanded_rows[galaxy[0]]} #{expanded_columns[galaxy[1]]} --> #{ng}\n"
  ng
end
pp expanded_galaxies

# p expanded_galaxies.length

total_distance = 0
expanded_galaxies.combination(2).each.with_index(1) do |(g1, g2), _i|
  distance = (g1[0] - g2[0]).abs + (g1[1] - g2[1]).abs
  total_distance += distance
  # print "#{i.to_s.rjust(2, ' ')} : #{g1} --> #{g2} : #{distance}\n"
end
p total_distance
