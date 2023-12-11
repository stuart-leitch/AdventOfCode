# frozen_string_literal: true

require 'test/unit'
require_relative './hand'

class HandTest < Test::Unit::TestCase
  def test_type
    assert_equal 'FH', Hand.new('33322').type
    assert_equal 'FH', Hand.new('32323').type
    assert_equal '4',  Hand.new('3J333').type

    assert_equal 'HC', Hand.new('789TQ').type
    assert_equal 'P',  Hand.new('45676').type
    assert_equal '2P', Hand.new('3344A').type
    assert_equal '3',  Hand.new('8885Q').type
    assert_equal 'FH', Hand.new('33322').type
    assert_equal '4',  Hand.new('Q3QQQ').type
    assert_equal '5',  Hand.new('TTTTT').type

    assert_equal 'HC', Hand.new('78JTQ').type
    assert_equal 'P',  Hand.new('4J676').type
    assert_equal '2P', Hand.new('3344J').type
    assert_equal '3',  Hand.new('888JQ').type
    assert_equal 'FH', Hand.new('333JJ').type
    assert_equal '4',  Hand.new('QJQQQ').type
    assert_equal '5',  Hand.new('TTTTT').type
    assert_equal '5',  Hand.new('JJJJJ').type

    assert_equal 'P',  Hand.new('J3J87').type
    assert_equal '3',  Hand.new('J3J8J').type
  end

  def test_score
    assert_equal '050309030903'.to_i, Hand.new('39393').score
    assert_equal '050303030909'.to_i, Hand.new('33399').score
  end

  def test_improved_type
    assert_equal 'FH', Hand.new('33322').improved_type
    assert_equal 'FH', Hand.new('32323').improved_type
    assert_equal '4',  Hand.new('3J323').improved_type
    assert_equal '5',  Hand.new('3J333').improved_type

    assert_equal 'HC', Hand.new('789TQ').improved_type
    assert_equal 'P',  Hand.new('45676').improved_type
    assert_equal '2P', Hand.new('3344A').improved_type
    assert_equal '3',  Hand.new('8885Q').improved_type
    assert_equal 'FH', Hand.new('33322').improved_type
    assert_equal '4',  Hand.new('Q3QQQ').improved_type
    assert_equal '5',  Hand.new('TTTTT').improved_type

    assert_equal 'P', Hand.new('78JTQ').improved_type
    assert_equal '3',  Hand.new('4J676').improved_type
    assert_equal 'FH', Hand.new('3344J').improved_type
    assert_equal '4',  Hand.new('888JQ').improved_type
    assert_equal '5',  Hand.new('333JJ').improved_type
    assert_equal '5',  Hand.new('QJQQQ').improved_type
    assert_equal '5',  Hand.new('TTTTT').improved_type
    assert_equal '5',  Hand.new('JJJJJ').improved_type

    assert_equal '3',  Hand.new('J3J87').improved_type
    assert_equal '4',  Hand.new('J3J8J').improved_type
  end

  def test_improved_score
    assert_equal '050309030903'.to_i, Hand.new('39393').improved_score
  end

  def test_beats
    assert_equal true, Hand.new('33322').beats?('32323')
  end

  def test_old_beats
    assert_equal true, Hand.new('33322').beats_old?('32323')
  end
end
