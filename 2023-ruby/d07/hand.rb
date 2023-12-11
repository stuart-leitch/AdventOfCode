# frozen_string_literal: true

class Hand
  TYPE_SCORE = { 'HC' => 1, 'P' => 2, '2P' => 3, '3' => 4,
                 'FH' => 5, '4' => 6, '5' => 7 }.freeze
  CARD_SCORE = { 'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 1, 'T' => 10,
                 '9' => 9,  '8' => 8,  '7' => 7, '6' => 6,
                 '5' => 5,  '4' => 4,  '3' => 3, '2' => 2 }.freeze

  attr_reader :hand, :type, :cards, :score, :improved_type, :improved_score, :bid

  def initialize(hand, bid = 0)
    @hand = hand
    @cards = @hand.split('')
    @bid = bid
    set_type
    set_improved_type
    set_scores
  end

  def beats?(hand)
    @improved_score > Hand.new(hand).improved_score
  end

  def beats_old?(hand)
    competitor = Hand.new(hand)
    if @improved_type != competitor.improved_type
      TYPE_SCORE[@improved_type] > TYPE_SCORE[competitor.improved_type]
    else
      @cards.each_with_index do |card, i|
        next if card == competitor.cards[i]

        return CARD_SCORE[card] > CARD_SCORE[competitor.cards[i]]
      end
    end
  end

  def to_s
    "#{@hand} #{@cards} " +
      "#{@type.rjust(2, ' ')}--#{hand.count('J')}-->#{@improved_type.rjust(2, ' ')} " +
      "#{@score.to_s.rjust(12, '0')}-->#{@improved_score.to_s.rjust(12, '0')} " +
      "Bid: #{@bid.to_s.rjust(3, ' ')}"
  end

  private

  def set_type
    types = {
      [5] => '5',
      [4, 1] => '4',
      [3, 2] => 'FH',
      [3, 1, 1] => '3',
      [2, 2, 1] => '2P',
      [2, 1, 1, 1] => 'P',
      [1, 1, 1, 1, 1] => 'HC'
    }.freeze

    @type = types[@cards.uniq.map { |k| hand.count(k) }.sort.reverse]
  end

  def set_scores
    scr = TYPE_SCORE[@type].to_s.rjust(2, '0')
    imp_scr = TYPE_SCORE[@improved_type].to_s.rjust(2, '0')

    @cards.each do |card|
      scr << CARD_SCORE[card].to_s.rjust(2, '0')
      imp_scr << CARD_SCORE[card].to_s.rjust(2, '0')
    end
    @score = scr.to_i
    @improved_score = imp_scr.to_i
  end
end

def set_improved_type
  bump = { '5' => '5',
           '4' => '5',
           'FH' => '4',
           '3' => '4',
           '2P' => 'FH',
           'P' => '3',
           'HC' => 'P' }.freeze

  @improved_type = @type

  return unless @hand.include?('J')

  @hand.count('J').times do
    @improved_type = bump[@improved_type]
  end
end
