require "set"

$readings = File.readlines("test_input").map(&:strip).map!(&:chars)

def get_val(p)
  r, c = p[0], p[1]
  cols = $readings[0].length
  rows = $readings.length
  return nil if r >= rows || r < 0 || c >= cols || c < 0
  $readings[r][c].to_i
end

def find_low_pts()
  basins = []
  $readings.each_with_index do |row, r|
    row.each_with_index do |e, c|
      if e.to_i < get_neighbour_vals(r, c).min
        basins << [r, c]
      end
    end
  end
  return basins
end

def is_basin?(p)
  height = get_val(p)
  height != nil && height != 9
end

def get_neighbour_vals(r, c)
  get_neighbours([r, c])
    .map { |p| get_val(p) }.compact
end

def get_neighbours(p)
  r, c = p[0], p[1]
  return [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]]
end

def extend_basin(basin)
  tb = Set.new()
  basin.each do |point|
    get_neighbours(point).each do |pt|
      tb << pt if is_basin?(pt)
    end
  end

  sizewas = basin.length
  basin.merge(tb)

  extend_basin(basin) if basin.length > sizewas
  return basin
end

# Part 1
p low_points = find_low_pts
p low_points.count
p low_points.each.map { |lpt| get_val(lpt) }
    .reduce(0) { |risk, height| risk + (1 + height) }

# Part 2
p low_points.each.map { |lpt| extend_basin(Set[lpt]) }
    .map(&:size)
    .sort.reverse.slice(0, 3)
    .reduce(1) { |product, size| product * size }
