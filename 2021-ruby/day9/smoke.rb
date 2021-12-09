require "set"

$readings = File.readlines("input").map(&:strip).map(&:chars)

def get_val(r, c)
  cols = $readings[0].length
  rows = $readings.length
  return nil if r >= rows || r < 0 || c >= cols || c < 0
  $readings[r][c].to_i
end

def get_vals(r, c)
  vals = []
  vals << get_val(r - 1, c)
  vals << get_val(r + 1, c)
  vals << get_val(r, c - 1)
  vals << get_val(r, c + 1)
  return vals
end

def find_basins()
  basins = []
  $readings.each_with_index { |row, r|
    row.each_with_index { |e, c|
      if e.to_i < get_vals(r, c).compact.min
        basins << [r, c]
      end
    }
  }
  return basins
end

def is_basin?(r, c)
  height = get_val(r, c)
  height != nil && height != 9
end

def extend_basin(basin)
  tb = Set.new()
  basin.each do |p|
    r, c = p[0], p[1]
    tb << [r - 1, c] if is_basin?(r - 1, c)
    tb << [r + 1, c] if is_basin?(r + 1, c)
    tb << [r, c - 1] if is_basin?(r, c - 1)
    tb << [r, c + 1] if is_basin?(r, c + 1)
  end
  sizewas = basin.length
  basin.merge(tb)
  sizeis = basin.length
  extend_basin(basin) if sizeis > sizewas
  return tb
end

def get_basin_size(r, c)
  print "basin: #{r},#{c} -- "
  basin = Set.new()
  basin << [r, c]
  extend_basin(basin)
  print "#{basin} (#{basin.length})\n"
  return basin.length
end

# Part 1
p basins = find_basins
p basins.length
p basins.each.map { |b| get_val(b[0], b[1]) }.reduce(0) { |c, e| c + 1 + e }

# Part 2
p basins.each.map { |b| get_basin_size(b[0], b[1]) }
    .sort.reverse.slice(0, 3)
    .reduce(1) { |sum, num| sum * num }
