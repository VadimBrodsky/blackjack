# BlackJack

# Create Deck
# Give 2 cards to player
# Give 2 cards to dealer
# Ask player for hit or stay
#  - If hit add 1 card
#  - If stay move to dealer turn
# Dealer opens cards
# If cards less than 17 dealer hits until over 17 or bust
# Compare sums to find out winner

require 'pry'
def e
  exit!
end


require_relative 'lib/blackjack_classes'

player = Player.new ("Vadim")
p player


d = Deck.new

binding.pry
