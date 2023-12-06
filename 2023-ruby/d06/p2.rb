times, distances = File.read(ARGV[0]).split("\n")
times = times.split(':')[1].split.map(&:to_i)
distances = distances.split(':')[1].split.map(&:to_i)
print "Times: #{times}\n"
print "Distances: #{distances}\n"

overall_winners = 1
times.each.with_index(1) do |time, race|
  winners = 0
  print "#{race}: #{time} (#{distances[race - 1]})\n"
  time.times do |t|
    d = t * (time - t)
    winners += 1 if d > distances[race - 1]
    # print "#{d} "
  end
  print "\n"
  print "Winners: #{winners}\n"
  overall_winners *= winners
end
print "Overall winners: #{overall_winners}\n"
