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
    print "\n"
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

# input_data = [[22, 13, 17, 11, 0], [8, 2, 23, 4, 24], [21, 9, 14, 16, 7], [6, 10, 3, 18, 5], [1, 12, 20, 15, 19]]

# cust1 = Board.new(input_data)

# cust1.print_board()

# (0..30).each do |t|
#   print "Draw Number: #{t}\n"
#   cust1.check_number(t)
#   cust1.print_board
#   break if cust1.check_for_win == true
# end

f = File.readlines("numbers")
nums = f[0].split(",").map { |l| l.to_i }

brd = []
brds = []
File.readlines("boards").each_with_index do |l, i|
  a = l.strip.split(" ").map { |v| v.to_i }
  if a.length == 0
    r = Board.new (brd)
    brds << r
    brd = []
  else
    brd << a
  end
end

brds.each do |b|
  # b.print_board
end

catch :winner do
  nums.each do |n|
    print "Number: #{n}\n"
    brds.each do |b|
      b.check_number(n)
      if b.check_for_win == true
        b.print_board
        print "WIN: #{b.score}\n"
        throw :winner
      end
    end
  end
end
