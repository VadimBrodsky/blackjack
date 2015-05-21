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
  game_deck   = create_deck(DECK)
  player_hand = give_cards_from(game_deck, 2)
  dealer_hand = give_cards_from(game_deck, 2)
  player_name = 'Player'

  print_game_state([dealer_hand[0], false], player_hand, player_name)
  player_choice = ask_hit_or_stay

  # player draws
  if player_choice == 'h'
    loop do
      player_hand = hit(player_hand, game_deck)
      print_game_state([dealer_hand[0], false], player_hand, player_name)
      break if bust?(player_hand)
      player_choice = ask_hit_or_stay
      break if player_choice == 's'
    end
  end

  if bust?(player_hand)
    print_game_state(dealer_hand, player_hand, player_name)
    puts("#{player_name} is bust!")
    line_break
  else
    print_game_state(dealer_hand, player_hand, player_name, 'Dealer Draws')
    if sum_of(dealer_hand) <= DEALER_MAXIMUM
      loop do
        dealer_hand = hit(dealer_hand, game_deck)
        print_game_state(dealer_hand, player_hand, player_name, 'Dealer Draws')
        print_hand_for('Dealer', dealer_hand)
        say("Sum of: #{sum_of(dealer_hand)}")
        line_break
        break if bust?(dealer_hand)
        break if sum_of(dealer_hand) >= DEALER_MAXIMUM
      end
    end
    puts "Dealer BUST!\n\n" if bust?(dealer_hand)
  end

  winner = name_of_winner(player_hand, dealer_hand, player_name)
  print_winner(winner)

  line_break
  play_game if ask_play_again == 'y'
end

play_game
