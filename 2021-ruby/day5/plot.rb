class Plot
  @plot_data = []

  def initialize(size)
    @size = size
    @plot_data = Array.new(@size) { Array.new(@size, 0) }
  end

  def add_ventline(ventline)
    ventline.get_coords.each do |c|
      mark_coord(c)
    end
  end

  def mark_coord(coord)
    @plot_data[coord.y][coord.x] += 1
  end

  def print_plot
    @plot_data.each do |r|
      r.each do |c|
        if c == 0
          print "."
        else
          print c
        end
      end
      print "\n"
    end
  end

  def danger
    dz = 0
    @plot_data.each do |r|
      r.each do |c|
        if c > 1
          dz += 1
        end
      end
    end
    return dz
  end
end

class Coord
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    print "[#{@x},#{@y}]\n"
  end
end

class VentLine
  def initialize(txt)
    c = txt.split(" -> ")
    @start_x, @start_y = c[0].split(",").map { |z| z.to_i }
    @end_x, @end_y = c[1].split(",").map { |z| z.to_i }
  end

  def get_coords
    # print_line
    cl = []
    if ishorizontal == true
      print "Horizontal\n"
      if @start_x > @end_x
        print "swap\n"
        tmp = @start_x
        @start_x = @end_x
        @end_x = tmp
      end
      (@start_x..@end_x).each do |ex|
        cl << Coord.new(ex, @start_y)
      end
      return cl
    elsif isvertical == true
      print "Vertical\n"
      if @start_y > @end_y
        print "swap\n"
        tmp = @start_y
        @start_y = @end_y
        @end_y = tmp
      end
      (@start_y..@end_y).each do |ex|
        cl << Coord.new(@start_x, ex)
      end
      return cl
    else
      if @start_x > @end_x # Always work left to right
        print "swap\n"
        t_x = @start_x
        t_y = @start_y
        @start_x = @end_x
        @start_y = @end_y
        @end_x = t_x
        @end_y = t_y
      end
      if @end_y > @start_y # Going down
        print "Diagonal Down\n"
        pts = @end_y - @start_y
        (0..pts).each do |p|
          cl << Coord.new(@start_x + p, @start_y + p)
        end
        return cl
      else # Going up (y decreasing)
        print "Diagonal Up\n"
        pts = @start_y - @end_y
        (0..pts).each do |p|
          cl << Coord.new(@start_x + p, @start_y - p)
        end
        return cl
      end
    end
    return @coords
  end

  def ishorizontal
    if @start_y == @end_y
      return true
    end
  end

  def isvertical
    if @start_x == @end_x
      return true
    end
  end

  def print_line
    print "#{@start_x}, #{@start_y}, #{@end_x}, #{@end_y}\n"
  end
end

p = Plot.new(1000)

f = File.readlines("input")
f.each do |l|
  # p = Plot.new(10)
  l.strip!
  p l
  p.add_ventline(VentLine.new(l))
  # p.print_plot
  # print "\n"
end
p.print_plot
p p.danger
