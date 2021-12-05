require_relative "board"

f = File.readlines("test_numbers")
nums = f[0].split(",").map { |l| l.to_i }

brd = []
brds = []
File.readlines("test_boards").each_with_index do |l, i|
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
  b.print_board
end

catch :end do
  winners = []
  nums.each do |n|
    print "Number: #{n}\n"
    brds.each do |b|
      print "Checking #{n} on Board #{b.id}\n"
      b.check_number(n)
      if b.check_for_win == true
        if winners.include? b.id
          #
        else
          winners << b.id
          print "WIN : #{b.score}\n"
          if winners.length == brds.length
            b.print_board
            throw :end
          end
        end
      end
    end
  end
end
