# frozen_string_literal: true

symbols = {}
File.open(ARGV[0]).readlines.map(&:chomp).each.with_index(1) do |line, line_num|
  print "#{line_num.to_s.rjust(7, ' ')}: #{line}\n"
  chars = line.chars
  chars.each.with_index(1) do |char, char_num|
    symbols[[char_num, line_num]] = char unless char == '.' || char =~ /[[:digit:]]/
  end
end
pp symbols
symbols.filter! { |_k, v| v == '*' }
pp symbols

numbers = []
File.open(ARGV[0]).readlines.map(&:chomp).each.with_index(1) do |line, line_num|
  print "#{line_num.to_s.rjust(7, ' ')}: #{line}\n"
  chars = line.chars << '.' # add a dummy char to the end of the line
  num = []
  adj = []
  chars.each.with_index(1) do |char, char_num|
    if char =~ /[[:digit:]]/
      num << char
      adj << [char_num - 1, line_num - 1]
      adj << [char_num - 1, line_num]
      adj << [char_num - 1, line_num + 1]

      adj << [char_num, line_num - 1]
      # adj << [char_num, line_num]
      adj << [char_num, line_num + 1]

      adj << [char_num + 1, line_num - 1]
      adj << [char_num + 1, line_num]
      adj << [char_num + 1, line_num + 1]
    elsif num.length > 0
      numbers << [num.join.to_i, adj.uniq]
      num = []
      adj = []
    end
  end
end
pp numbers

gears = {}
symbols.each do |k, _v|
  gears.store(k, [])
end

numbers.each do |num|
  partnum = num[0]
  adj = num[1]
  adj.each do |a|
    gears[a] << partnum if symbols[a] == '*'
  end
end
pp gears

ratio_sum = 0
gears.each_value do |v|
  next unless v.length == 2

  print "#{v}\n"
  p ratio = v[0] * v[1]
  ratio_sum += ratio
end
p ratio_sum
