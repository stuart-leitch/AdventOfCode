# frozen_string_literal: true

cards = []
File.open(ARGV[0]).readlines.map(&:chomp).each do |card|
  # puts card
  card_no, winning, your = card.split(Regexp.union([':', '|']))
  winning = winning.split.map(&:to_i)
  your = your.split.map(&:to_i)
  list_matches = winning.intersection(your)
  matches = list_matches.length
  # print "<#{card_no}> <#{winning}> <#{your}> <#{list_matches}> <#{matches}>\n"
  cards << { matches:, copies: 1 }
end

cards.each.with_index(1) do |card, card_num|
  card[:matches].times { |i| cards[card_num + i][:copies] += card[:copies] }
end

p cards.reduce(0) { |acc, card| acc + card[:copies] }
