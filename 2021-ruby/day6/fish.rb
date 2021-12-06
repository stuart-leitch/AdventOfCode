fish = Array.new(9, 0)

l = File.readlines("input")
p l

l[0].split(",").each { |f| fish[f.to_i] += 1 }

def next_day(fish)
  fish_next = []
  fish_next[8] = fish[0]
  fish_next[7] = fish[8]
  fish_next[6] = fish[7] + fish[0]
  fish_next[5] = fish[6]
  fish_next[4] = fish[5]
  fish_next[3] = fish[4]
  fish_next[2] = fish[3]
  fish_next[1] = fish[2]
  fish_next[0] = fish[1]
  return fish_next
end

def summary(day, fish)
  print "Day #{day}: #{fish}\nTotal fish: #{fish.sum}\n"
end

256.times { |d|
  fish = next_day(fish)
  summary(d + 1, fish)
}
