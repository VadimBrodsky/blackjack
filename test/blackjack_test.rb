require 'minitest/autorun'
require_relative '../lib/blackjack_classes.rb'

# Testing BlackJack Methods
class GameTest < Minitest::Test
  def setup
    @d1 = Deck.new
    @d2 = Deck.new
  end

  def test_number_of_cards
    assert_equal Card.all_cards.count, 52
  end

  def test_card_should_init
    good_card = Card.new('3', 'spades')
    bad_card = Card.new('joker', 'hearts')
    refute_nil good_card.face
    refute_nil good_card.suit
    assert_nil bad_card.face
  end

  def test_decks_should_shuffle
    assert_equal @d1.to_a, @d1.to_a
    refute_equal @d1.to_a, @d2.to_a
  end
end
