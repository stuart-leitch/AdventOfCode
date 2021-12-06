input = "input"
# input = "test_input"

entries = File.readlines(input).map { |line| line.chomp }
goodies = 0

entries.each do |entry|
  puts entry
  policy, password = entry.split(":")
  p_range, p_char = policy.split(" ")
  p_min, p_max = p_range.split("-")
  count = password.count(p_char)
  print "'#{p_char}' must appear between #{p_min} and #{p_max} times in #{password}: #{count} "
  if count >= p_min.to_i && count <= p_max.to_i
    p "good"
    goodies += 1
  else
    p "bad"
  end
end
p goodies
