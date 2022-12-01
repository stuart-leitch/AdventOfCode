require "set"

b, e = File.readlines("input", "\n\n")

base = b.strip
p base
base = base.chars
pairs = {}
(base.count - 1).times { |i|
  pairs[base[i] + base[i + 1]] = 1
}
# p pairs
# @dots = dots.map { |d| d.split(",") }.map { |d| [d[0].to_i, d[1].to_i] }

expansions = e.split("\n")
expansions = expansions.map { |e| e.split(" -> ") }
expansions = expansions.map { |e, f| (e << f).chars }
expansions = expansions.map { |e| [e[0] + e[1], e[0] + e[2], e[2] + e[1]] }

# p expansions.each { |e| "#{e}\n" }

10.times do |r|
  p r
  # p pairs
  next_pairs = {}
  pairs.each do |k, v|
    insertion = expansions.select { |e| e[0] == k }[0]
    i1, i2, i3 = insertion
    # print "<#{k}>, <#{v}>, <#{insertion}>\n"
    next_pairs[i2] == nil ? next_pairs[i2] = v : next_pairs[i2] += v
    next_pairs[i3] == nil ? next_pairs[i3] = v : next_pairs[i3] += v
    # p next_pairs
  end
  pairs = next_pairs
  pairs.values.sum
end

tots = {}
pairs.each do |k, v|
  tots[k[0]] == nil ? tots[k[0]] = v : tots[k[0]] += v
  tots[k[1]] == nil ? tots[k[1]] = v : tots[k[1]] += v
end
p tots

p tots.values.max / 2
p tots.values.min / 2
p tots.values.max / 2 - tots.values.min / 2
