require "set"

def contains?(set, subset)
  subset.chars.to_set.subset?(set.chars.to_set)
end

def decode(code)
  obs, output, ans = code.split("|")

  obs = obs.split(" ").map { |e| e.chars.sort.join }.sort_by { |s| s.length }
  output = output.split(" ").map { |e| e.chars.sort.join }

  codes = [] # Beware! Order matters (i.e. to find code for '9' requires code for '4')
  codes[1] = obs.find { |e| e.length == 2 }
  codes[4] = obs.find { |e| e.length == 4 }
  codes[7] = obs.find { |e| e.length == 3 }
  codes[8] = obs.find { |e| e.length == 7 }
  codes[9] = obs.find { |e| e.length == 6 && contains?(e, codes[4]) }
  codes[3] = obs.find { |e| e.length == 5 && contains?(e, codes[1]) }
  codes[6] = obs.find { |e| e.length == 6 && !contains?(e, codes[1]) }
  codes[0] = obs.find { |e| e.length == 6 && contains?(e, codes[1]) && !contains?(e, codes[4]) }
  codes[2] = obs.find { |e| e.length == 5 && !contains?(codes[9], e) }
  codes[5] = obs.find { |e| e.length == 5 && contains?(codes[9], e) && !contains?(e, codes[1]) }

  return output.map { |e| codes.index(e.chars.sort.join) }.join.to_i
end

print "Part1: "
p File.readlines("input").map { |line|
    line.split("|")[1].split(" ")
      .map(&:length)
      .count { |e| [2, 3, 4, 7].include?(e) }
  }
    .sum

print "Part2: "
p File.readlines("input")
    .map { |line| decode(line) }
    .sum
