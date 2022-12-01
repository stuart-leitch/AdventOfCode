elves = File.foreach('input', "\n\n").map(&:rstrip).map { |elf| elf.split.map(&:to_i).sum }
p "Part 1: #{elves.max}"
p "Part 2: #{elves.max(3).sum}"
