# BlackJack

require 'pry'
require_relative 'lib/blackjack_methods'

# Create Deck
# Give 2 cards to player
# Give 2 cards to dealer
# Ask player for hit or stay
#  - If hit add 1 card
#  - If stay move to dealer turn
# Dealer opens cards
# If cards less than 17 dealer hits until over 17 or bust
# Compare sums to find out winner

def play_game
  puts 'Welcome to BlackJack!'

  game_deck   = create_deck(DECK)
  player_hand = give_cards_from(game_deck, 2)
  dealer_hand = give_cards_from(game_deck, 2)

  print_hand_for('Player', player_hand)
  say("With the sum of #{sum_of(player_hand)}")
  puts "-------------"
  print_hand_for('Dealer', dealer_hand)
  say("With the sum of #{sum_of(dealer_hand)}")

  # binding.pry
end

play_game
