class Octogrid
  def initialize
    @charges = Array.new(10, Array.new(10, 0))
    lines = File.readlines("input")
    lines.each_with_index do |line, row_num|
      @charges[row_num] = line.strip.chars.map(&:to_i)
    end
    pr
  end

  def charge_grid
    @charges.length.times { |r|
      @charges[0].length.times { |c|
        @charges[r][c] += 1
      }
    }
  end

  def pr
    @charges.length.times { |r|
      print "#{@charges[r].join}\n"
    }
    print "\n"
  end

  def charge_cell(r, c)
    @charges[r][c] += 1
  end

  def discharge_cell(r, c)
    @charges[r][c] = 0
  end

  def charge_neighbours(r, c)
    neighbours = [[r - 1, c - 1], [r - 1, c], [r - 1, c + 1], [r, c - 1], [r, c + 1], [r + 1, c - 1], [r + 1, c], [r + 1, c + 1]]
    neighbours.delete_if { |n| n[0] < 0 }
    neighbours.delete_if { |n| n[1] < 0 }
    neighbours.delete_if { |n| n[0] > 9 }
    neighbours.delete_if { |n| n[1] > 9 }
    neighbours.each { |n| charge_cell(n[0], n[1]) }
    # print "Neighbours of [#{r},#{c}]: #{neighbours}\n"
  end

  def cell_flash(r, c)
    if @charges[r][c] > 9 && !@has_flashed.include?([r, c])
      @flashes += 1
      @has_flashed << [r, c]
      charge_neighbours(r, c)
      # print "flash! #{r},#{c}\n"
      @charges[r][c] = 0
    end
  end

  def flash
    snap_flash = @flashes
    @charges.length.times { |r|
      @charges[0].length.times { |c|
        cell_flash(r, c)
      }
    }
    flash if @flashes > snap_flash
    @has_flashed.each { |o| discharge_cell(o[0], o[1]) }
  end

  def step(num)
    @flashes = 0
    @has_flashed = []
    charge_grid
    flash

    pr
    print "step #{num}: Flashes: #{@flashes}\n\n"
    return @flashes
  end
end

octogrid = Octogrid.new()
tflash = 0
1000.times { |s|
  sflash = 0
  sflash += octogrid.step(s + 1)
  tflash += sflash
  break if sflash == 100
}
p tflash
