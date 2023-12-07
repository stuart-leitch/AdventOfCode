# frozen_string_literal: true

def get_type(hand)
  counts = hand.split('').uniq.map { |k| hand.count(k) }.sort.reverse
  case counts
  when [5]
    '5'
  when [4, 1]
    '4'
  when [3, 2]
    'FH'
  when [3, 1, 1]
    '3'
  when [2, 2, 1]
    '2P'
  when [2, 1, 1, 1]
    'P'
  when [1, 1, 1, 1, 1]
    'HC'
  end
end

File.open(ARGV[0]).readlines.map(&:chomp).each do |line|
  hand, bid = line.split
  type = get_type(hand)
  cards = hand.split('')
  print "#{cards}, (#{bid}) #{type} "
  print "\n"
end
