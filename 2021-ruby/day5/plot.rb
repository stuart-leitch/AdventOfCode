class Plot
  @plot_data = []

  def initialize(size)
    @size = size
    @plot_data = Array.new(@size) { Array.new(@size, 0) }
  end

  def add_ventline(ventline)
    if ventline.ishorizontal == true
      print "ok, I'll add horizontal line\n"
      ventline.get_coords.each do |c|
        mark_coord(c)
      end
    elsif ventline.isvertical == true
      print "ok, I'll add vertical line\n"
      ventline.get_coords.each do |c|
        mark_coord(c)
      end
    else
      print "only horizontal or vertical lines supported\n"
    end
  end

  def mark_coord(coord)
    print "Marking [#{coord.x},#{coord.y}]\n"
    @plot_data[coord.y][coord.x] += 1
  end

  def print_plot
    @plot_data.each do |r|
      r.each do |c|
        if c == 0
          print "."
        else
          print "#{c}"
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
    print_line
    cl = []
    if ishorizontal == true
      if @start_x > @end_x
        tmp = @start_x
        @start_x = @end_x
        @end_x = tmp
      end
      (@start_x..@end_x).each do |ex|
        cl << Coord.new(ex, @start_y)
      end
      return cl
    elsif isvertical == true
      if @start_y > @end_y
        tmp = @start_y
        @start_y = @end_y
        @end_y = tmp
      end
      (@start_y..@end_y).each do |ex|
        cl << Coord.new(@start_x, ex)
      end
      return cl
    else
      # unsupported
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

p = Plot.new(10)
p.print_plot

f = File.readlines("test_input")
f.each do |l|
  l.strip!
  p l
  p.add_ventline(VentLine.new(l))
  p.print_plot
  p p.danger
  print "\n"
  # break
end
