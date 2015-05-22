require 'minitest/autorun'
require 'blackjack_methods'

# Testing BlackJack Methods
class GameTest < Minitest::Test
  def setup
    @deck_1 = create_deck(DECK)
    @deck_2 = create_deck(DECK)
    @bust_hand  = [%w(9 diamonds), %w(8 hearts), %w(10 diamonds)]
    @small_hand = [%w(5 diamonds), %w(3 hearts)]
    @large_hand = [%w(9 diamonds), %w(10 diamonds)]
    @small_ace_hand = [%w(10 diamonds), %w(5 hearts), %w(ace spades)]
    @large_ace_hand = [%w(3 diamonds), %w(5 hearts), %w(ace spades)]
    @double_aces_hand = [%w(ace spades), %w(ace hearts), %w(ace clubs)]
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

  def test_hitting_should_remove_card_from_deck
    full_deck = create_deck(DECK)
    full_deck_count = full_deck.count
    hit([], full_deck)
    partial_deck_count = full_deck.count
    refute_equal full_deck_count, partial_deck_count
  end

  def test_hand_should_bust
    assert bust?(@bust_hand), true
    refute bust?(@small_hand), true
  end

  def test_sum_of_cards
    assert_equal sum_of(@small_hand), 8
    assert_equal sum_of(@large_hand), 19
    assert_equal sum_of(@large_ace_hand), 19
    assert_equal sum_of(@small_ace_hand), 16
    assert_equal sum_of(@double_aces_hand), 13
  end

  def test_correct_winner
    assert name_of_winner(@large_hand, @small_hand), 'Player'
    assert name_of_winner(@small_hand, @bust_hand),  'Player'
    assert name_of_winner(@small_hand, @large_hand), 'Dealer'
    assert name_of_winner(@bust_hand, @small_hand), 'Dealer'
  end
end
