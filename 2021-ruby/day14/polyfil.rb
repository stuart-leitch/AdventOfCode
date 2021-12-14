require "set"

b, e = File.readlines("test_input", "\n\n")

base = b.strip
base = base.chars
p base
# @dots = dots.map { |d| d.split(",") }.map { |d| [d[0].to_i, d[1].to_i] }

expansions = e.split("\n")
expansions = expansions.map { |e| e.split(" -> ") }
expansions = expansions.map { |e, f| (e << f).chars }

p expansions

# p base.length

next_string = ""
4.times do
  next_string = base[0]
  (base.length - 1).times do |i|
    insertion = expansions.select { |e| e[0] == base[i] && e[1] == base[i + 1] }[0][2]
    print "#{base[i]} <#{insertion}> #{base[i + 1]}\n"
    # next_string << base[i]
    next_string << insertion
    next_string << base[i + 1]
    # p next_string
  end
  p next_string
  p next_string.length
  base = next_string
end

p base
out = next_string.chars.tally
p out.values.max
p out.values.min
p out.values.max - out.values.min
