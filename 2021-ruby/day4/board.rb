class Board
  UNMARKED = 1
  MARKED = 0

  @@no_of_boards = 0
  @@last_number = nil

  @board_data = [[]]
  @board_status = [[]]

  def initialize(data)
    @@no_of_boards += 1
    @id = @@no_of_boards

    @board_data = data

    @board_status = Array.new(5) { Array.new(5, UNMARKED) }
  end

  def print_board
    print "BOARD #{@id}\n"
    (0..4).each do |r|
      e = @board_data[r].zip(@board_status[r]).map { |x, y| x * y }
      print "#{@board_data[r]}\t#{@board_status[r]} #{row_score(r)}\t#{e}\n"
    end
    print "\t\t\t"
    (0..4).each do |c|
      print " #{col_score(c)} "
    end
    print "\t\t#{remaining}\n"
  end

  def value(r, c)
    return @board_data[r][c]
  end

  def status(r, c)
    return @board_status[r][c]
  end

  def mark(r, c)
    @board_status[r][c] = MARKED
  end

  def check_number(num)
    @@last_number = num
    (0..4).each do |r|
      (0..4).each do |c|
        if value(r, c) == num
          mark(r, c)
        end
      end
    end
  end

  def bd
    return @board_data
  end

  def id
    return @id
  end

  def check_for_win
    (0..4).each do |v|
      if col_score(v) == 5 || row_score(v) == 5
        return true
      end
    end
    return false
  end

  def score
    return @@last_number * remaining
  end

  def row_score(row)
    return @board_status[row].select { |v| v == MARKED }.length
  end

  def col_score(col)
    s = 0
    (0..4).each do |v|
      if status(v, col) == MARKED
        s += 1
      end
    end
    return s
  end

  def remaining
    t = 0
    (0..4).each do |r|
      (0..4).each do |c|
        if status(r, c) == 1
          t += value(r, c)
        end
      end
    end
    return t
  end
end
