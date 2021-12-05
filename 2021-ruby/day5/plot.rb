require "digest"

class Plot
  def initialize(size)
    @plot_data = Array.new(size) { Array.new(size, 0) }
  end

  def add_ventline(ventline)
    ventline.points.each { |point| mark(point) }
  end

  def mark(point)
    @plot_data[point.y][point.x] += 1
  end

  def to_s
    strout = ""
    @plot_data.each do |r|
      r.each { |c| strout += (c == 0 ? "." : c.to_s) }
      strout += "\n"
    end
    return strout
  end

  def danger
    dz = 0
    maxd = 0
    @plot_data.each do |r|
      r.each do |c|
        dz += 1 if c > 1
        maxd = c if c > maxd
      end
    end
    return dz, maxd
  end
end

class Coord
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x.to_i, y.to_i
  end
end

class VentLine
  attr_reader :points

  def initialize(txt)
    txt.strip!
    print "#{txt} : "
    c = txt.split(" -> ")
    @x1, @y1 = c[0].split(",").map { |z| z.to_i }
    @x2, @y2 = c[1].split(",").map { |z| z.to_i }

    flip if @x1 > @x2 # Right to Left
    flip if @x1 == @x2 && @y1 > @y2 # Vertical Up

    calc_points
  end

  def flip
    xt, yt = @x1, @y1
    @x1, @y1 = @x2, @y2
    @x2, @y2 = xt, yt
  end

  def calc_points
    set_params
    @points = []
    (0..@pts).each { |p| @points << Coord.new(@x1 + p * @dx, @y1 + p * @dy) }
  end

  def set_params
    if horizontal?
      @pts = @x2 - @x1
    else
      @pts = (@y2 - @y1).abs
    end

    @dx, @dy = 1, 1 if (@y2 > @y1) # Diagonal going down
    @dx, @dy = 1, -1 if (@y2 < @y1) # Diagonal going up (y decreasing)
    @dx, @dy = 0, 1 if vertical?
    @dx, @dy = 1, 0 if horizontal?

    print "#{@pts} : #{@dx} : #{@dy}\n"
  end

  def horizontal?
    @y1 == @y2
  end

  def vertical?
    @x1 == @x2
  end

  def print_line
    print "#{@x1}, #{@y1}, #{@x2}, #{@y2}\n"
  end
end

grid, file = 1000, "input"
grid, file = 10, "test_input"

p = Plot.new(grid)

File.readlines(file).each do |l|
  p.add_ventline(VentLine.new(l))
  # print "#{p.to_s}\n"
end

print "\n\nFinal Summary\n"
print "#{p.to_s}\n"
p p.danger
plotmd5 = Digest::MD5.hexdigest p.to_s
p plotmd5 == "285c7c9806741f38a4d73e0187a9325e" ? "Whoop" : "Booooooo!"
