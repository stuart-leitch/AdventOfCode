require "set"

def decode(code)
  p code
  p1, p2, ans = code.split("|")
  p p2

  q = p1.split(" ")
  q2 = []
  q.each do |e|
    q2 << e.chars.sort.join
  end

  p q2

  codes = Array.new(10)
  q2.each do |e|
    codes[1] = e if e.length == 2
    codes[4] = e if e.length == 4
    codes[7] = e if e.length == 3
    codes[8] = e if e.length == 7
  end
  q2.each do |e|
    next unless e.length == 6
    if codes[4].chars.to_set.subset?(e.chars.to_set)
      codes[9] = e
    elsif !codes[1].chars.to_set.subset?(e.chars.to_set)
      codes[6] = e
    else
      codes[0] = e
    end
  end

  q2.each do |e|
    next unless e.length == 5
    if codes[1].chars.to_set.subset?(e.chars.to_set)
      codes[3] = e
    elsif e.chars.to_set.subset?(codes[9].chars.to_set)
      codes[5] = e
    else
      codes[2] = e
    end
  end

  codes.each_with_index do |c, i|
    # print "#{i}: #{c}\n"
  end

  q = p2.split(" ")
  q2 = []
  q.each do |e|
    q2 << e.chars.sort.join
  end
  p q2

  values = []
  q2.each do |v|
    values << codes.index(v)
  end
  print "#{values.join.to_i} : #{values.join.to_i == ans.to_i}\n"
  return values.join.to_i
end

cnt = 0
sum = 0
File.readlines("input").each do |line|
  # line.strip!
  obs, output = line.strip.split("|")
  # p output
  vals = output.split(" ")
  # p vals
  vals.each do |v|
    # print "#{v} --> #{v.length}\n"
    cnt += 1 if [2, 3, 4, 7].include?(v.length)
  end
  sum += decode(line)
end
p cnt
p sum

# decode("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf")
