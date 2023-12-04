# frozen_string_literal: true

running_total = 0
File.open(ARGV[0]).readlines.map(&:chomp).each do |card|
  puts card
  card_no, winning, your = card.split(Regexp.union([':', '|']))
  winning = winning.split.map(&:to_i)
  your = your.split.map(&:to_i)
  matches = winning.intersection(your)
  points = matches.empty? ? 0 : 2**(matches.length - 1)
  print "<#{card_no}> <#{winning}> <#{your}> <#{matches}> <#{points}>\n"
  running_total += points
end
p ''
p running_total
