require 'minitest/autorun'
require 'blackjack_methods'

# Testing BlackJack Methods
class GameTest < Minitest::Test
  def setup
    @deck_1 = create_deck(DECK)
    @deck_2 = create_deck(DECK)
  end

  def test_two_decks_should_be_different
    assert_equal @deck_1, @deck_1
    refute_equal @deck_1, @deck_2
  end

  def test_removing_cards_should_remove_from_deck
    full_deck = create_deck(DECK).count
    partial_deck = give_cards_from(create_deck(DECK), 10).count
    refute_equal full_deck, partial_deck
  end

  def test_values_of_ace
    ace = CARDS['ace']
    assert_equal value_of(ace, 3),  11
    assert_equal value_of(ace, 10), 11
    assert_equal value_of(ace, 11), 1
    assert_equal value_of(ace, 15), 1
  end
end

def test_hitting_should_remove_card_from_deck
  full_deck = create_deck(DECK)
  full_deck_count = full_deck.count
  hit([], full_deck)
  partial_deck_count = full_deck.count
  refute_equal full_deck_count, partial_deck_count
end

def test_hand_should_bust
  bust_hand = [%w(9 diamonds),  %w(8 hearts), %w(10 diamonds)]
  good_hand = [%w(9 diamonds),  %w(8 hearts)]
  assert bust?(bust_hand), true
  refute bust?(good_hand), true
end
