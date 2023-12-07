# frozen_string_literal: true

TYPE_SCORE = { 'HC' => 1, 'P' => 2,  '2P' => 3, '3' => 4, '4' => 6, 'FH' => 5, '5' => 7 }.freeze
CARD_SCORE = { 'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11,
               'T' => 10, '9' => 9,  '8' => 8,  '7' => 7, '6' => 6,
               '5' => 5,  '4' => 4,  '3' => 3,  '2' => 2
              }.freeze

def get_type(hand)
  types = { 
    [5] => '5',
    [4, 1] => '4',
    [3, 2] => 'FH',
    [3, 1, 1] => '3',
    [2, 2, 1] => '2P',
    [2, 1, 1, 1] => 'P',
    [1, 1, 1, 1, 1] => 'HC'
  }
  types[hand.split('').uniq.map { |k| hand.count(k) }.sort.reverse]
end

def beats?(hand1, hand2)
  type1 = get_type(hand1)
  type2 = get_type(hand2)
  if type1 != type2
    TYPE_SCORE[type1] > TYPE_SCORE[type2]
  else
    cards1 = hand1.split('')
    cards2 = hand2.split('')
    cards1.each_with_index do |card, i|
     next if card == cards2[i]
      return CARD_SCORE[card] > CARD_SCORE[cards2[i]] 
    end
  end
end

hands = []
File.open(ARGV[0]).readlines.map(&:chomp).each do |line|
  hand, bid = line.split
  hands << { hand: hand, bid: bid.to_i }
end

# t = 'QQJQA'
# hands.each do |hand|
#   print "#{hand[:hand]} (#{get_type(hand[:hand])}) v #{t} (#{get_type(t)}) "
#   win = beats?(hand[:hand], t)
#   print "#{win}\n"
# end

p '-------------------'

total = 0
hands.sort! { |a, b| beats?(a[:hand], b[:hand]) ? 1 : -1 }
hands.each.with_index(1) do |hand, r|
  print "#{r} : #{hand[:hand]} (#{get_type(hand[:hand])}) (#{hand[:bid]}) ==> #{r*hand[:bid]}\n"
  total += r * hand[:bid]
end
print "Total: #{total}\n"
