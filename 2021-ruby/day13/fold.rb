class Grid
  def initialize
    d, f = File.readlines("input", "\n\n")

    dots = d.split("\n")
    @dots = dots.map { |d| d.split(",") }.map { |d| [d[0].to_i, d[1].to_i] }

    folds = f.split("\n")
    folds = folds.map { |f| f.split(" ")[2] }
    @folds = folds.map { |f| f.split("=") }
  end

  def fold_up(y)
    print "Fold up @ #{y}\n"
    @dots = @dots.map do |d|
      if d[1] > y
        newy = 2 * y - d[1]
        [d[0], newy]
      else
        d
      end
    end
  end

  def fold_left(x)
    print "Fold left @ #{x}\n"
    @dots = @dots.map do |d|
      if d[0] > x
        newx = 2 * x - d[0]
        [newx, d[1]]
      else
        d
      end
    end
  end

  def print_grid
    v = @dots.map { |d| d[1] }.max + 1
    h = @dots.map { |d| d[0] }.max + 1
    print "#{h},#{v}\n"
    grid = Array.new(v) { Array.new(h, " ") }
    # grid.each do |r| print "#{r.join}\n" end

    @dots.each do |d|
      x, y = d
      # print "#{x},#{y}\n"
      grid[y][x] = "#"
    end
    grid.each do |r| print "#{r.join}\n" end
    print "\n"
  end

  def fold()
    @folds.each { |f| print "#{f}\n" }
    print_grid
    @folds.each do |f|
      fold_up(f[1].to_i) if f[0] == "y"
      fold_left(f[1].to_i) if f[0] == "x"
      print_grid
    end
  end

  def count_dots
    # dts = Set.new(@dots)
    print "#{@dots.uniq.count}\n"
  end
end

grid = Grid.new
grid.print_grid
grid.fold
grid.count_dots
