require 'minitest/autorun'
require_relative '../lib/blackjack_classes.rb'

# Testing BlackJack Methods
class GameTest < Minitest::Test
  def setup
    @d1 = Deck.new
    @d2 = Deck.new
    @h1 = Hand.new
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

  def test_card_value
    assert_equal Card.new('7', 'spades').value, 7
    assert_equal Card.new('king', 'clubs').value, 10
  end

  def test_decks_should_shuffle
    assert_equal @d1.to_a, @d1.to_a
    refute_equal @d1.to_a, @d2.to_a
  end

  def card_should_be_in_deck
    card = @d1.cards.first
    assert_equal @d1.cards.include?(card), true
  end

  def test_withdraw_card_from_deck
    card = @d1.draw_card
    assert_equal @d1.cards.include?(card), false
  end

  def test_hit_a_hand
    cards_in_hand = @h1.cards.length
    @h1.hit(@d1.draw_card)
    assert_equal @h1.cards.length, cards_in_hand + 1
  end

  def test_hand_value
    h = Hand.new
    h.hit( Card.new('7', 'spades') )
    assert_equal h.value, 7
    h.hit( Card.new('jack', 'clubs') )
    assert_equal h.value, 17
    h.hit( Card.new('4', 'diamond') )
    assert_equal h.value, 21
  end

  def test_first_ace
    h = Hand.new
    h.hit( Card.new('ace', 'hearts') )
    assert_equal h.value, 11
  end

  def test_ace_is_11
    h = Hand.new
    h.hit( Card.new('4', 'clubs') )
    h.hit( Card.new('ace', 'spades'))
    assert_equal h.value, 15
  end

  def test_ace_is_1
    h = Hand.new
    h.hit( Card.new('8', 'clubs') )
    h.hit( Card.new('king', 'clubs') )
    h.hit( Card.new('ace', 'spades'))
    assert_equal h.value, 19
  end

  def test_ace_switch
    h = Hand.new
    h.hit( Card.new('3', 'diamonds') )
    h.hit( Card.new('ace', 'spades') )
    assert_equal h.value, 14
    h.hit( Card.new('9', 'clubs'))
    assert_equal h.value, 13
    h.hit( Card.new('ace', 'hearts') )
    assert_equal h.value, 14
  end

  def test_two_aces
    h = Hand.new
    h.hit( Card.new('ace', 'spades') )
    h.hit( Card.new('ace', 'hearts') )
    assert_equal h.value, 12
  end

  def test_three_aces
    h = Hand.new
    h.hit( Card.new('ace', 'spades') )
    h.hit( Card.new('ace', 'hearts') )
    h.hit( Card.new('ace', 'clubs') )
    assert_equal h.value, 13
  end
end
