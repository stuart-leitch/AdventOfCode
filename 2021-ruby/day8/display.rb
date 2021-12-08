cnt = 0
File.readlines("input").each do |line|
  # line.strip!
  obs, output = line.strip.split("|")
  # p output
  vals = output.split(" ")
  p vals
  vals.each do |v|
    print "#{v} --> #{v.length}\n"
    cnt += 1 if [2, 3, 4, 7].include?(v.length)
  end
end
p cnt
