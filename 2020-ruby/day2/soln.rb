input = "input"
# input = "test_input"

entries = File.readlines(input).map { |line| line.chomp }
goodies = 0

entries.each do |entry|
  puts entry
  policy, password = entry.split(":")
  p_range, p_char = policy.split(" ")
  p_min, p_max = p_range.split("-")
  password.strip!
  c1 = password.chars[p_min.to_i - 1]
  c2 = password.chars[p_max.to_i - 1]

  print "'#{p_char}' must appear at #{p_min} or #{p_max} in #{password}: #{c1}, #{c2} "
  if (c1 == p_char) ^ (c2 == p_char)
    goodies += 1
    print " --> good\n"
  else
    print " --> bad\n"
  end
end
p goodies
