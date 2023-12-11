# frozen_string_literal: true

require './hand'

hands = File.open(ARGV[0]).readlines.map(&:chomp).map do |line|
  hand, bid = line.split
  Hand.new(hand, bid.to_i)
end

# hands.sort_by!(&:improved_score)
hands.sort! { |a, b| a.beats_old?(b.hand) ? 1 : -1 }

hands.each_cons(2) do |hand1, hand2|
  if hand1.improved_score > hand2.improved_score
    print "ALARM! #{hand1.cards} #{hand2.cards} #{hand1.improved_score} #{hand2.improved_score}\n"
  end
end

total = 0
hands.each_with_index do |hand, r|
  print "#{(r + 1).to_s.rjust(4, '0')} : "
  winning = (r + 1) * hand.bid

  print "#{hand} Wins: #{winning.to_s.rjust(6, '0')}, Total: #{total += winning}\n"
  # sum + winning
end
print "Total: #{total}\n"
