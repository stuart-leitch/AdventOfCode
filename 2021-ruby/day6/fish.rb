fish = Array.new(9, 0)

l = File.readlines("input")
p l

l[0].split(",").each { |f| fish[f.to_i] += 1 }

def next_day(fish)
  fish_next = []
  8.times { |c| fish_next[c] = fish[c + 1] }
  fish_next[8] = fish[0]
  fish_next[6] += fish[0]
  return fish_next
end

def summary(day, fish)
  print "Day #{day}: Total fish: #{fish.sum}\n"
end

256.times { |d|
  fish = next_day(fish)
  summary(d + 1, fish)
}
