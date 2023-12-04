# frozen_string_literal: true

stars = {}
numbers = []
File.open(ARGV[0]).readlines.map(&:chomp).each.with_index(1) do |line, line_num|
  chars = line.chars << '.' # add a dummy char to the end of the line (Woff hack)
  num = []
  adj = []
  chars.each.with_index(1) do |char, char_num|
    if char =~ /[[:digit:]]/
      num << char
      adj << [char_num - 1, line_num - 1]
      adj << [char_num - 1, line_num]
      adj << [char_num - 1, line_num + 1]
      adj << [char_num, line_num - 1]
      adj << [char_num, line_num + 1]
      adj << [char_num + 1, line_num - 1]
      adj << [char_num + 1, line_num]
      adj << [char_num + 1, line_num + 1]
    elsif !num.empty? || char == '*'
      stars[[char_num, line_num]] = [] if char == '*'
      numbers << [num.join.to_i, adj.uniq]
      num.clear
      adj.clear
    end
  end
end

numbers.each do |num|
  num[1].each do |a|
    next if stars[a].nil?

    stars[a] << num[0]
  end
end

gears = stars.filter { |_k, v| v.length == 2 }

ratio_sum = gears.reduce(0) { |acc, (_k, v)| acc + v[0] * v[1] }
p ratio_sum
