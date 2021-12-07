require_relative "lib/boarding_pass"

seats = Array.new(128, 0)
128.times do |r|
  8.times do |c|
    seats[8 * r + c] = 1
  end
end

max_i = 0
File.readlines("input").each do |str_pass|
  str_pass.strip!
  r, c, i = BoardingPass.decode(str_pass)
  seats[8 * r + c] = 2
  max_i = i if i > max_i
  # print "#{r}, #{c}, #{i}\n"
end

print "Max ID: #{max_i}\n"

empty = seats.each_index.select { |index| seats[index] == 1 }
empty.each do |e|
  if seats[e - 1] == 2 && seats[e + 1] == 2
    print "Your seat is(id): #{e} (#{e / 8},#{e % 8})\n"
  end
end
