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

# 4 decks of 52 cards
# Natural balckjack Ace + 10
# Natural blackjack beats any other hand of 3+ cards
# Soft hand - ace is counted 1 or 11 without busting
# Hard hand - ace is counter as a 1 only
# Player cards are dealt face up
# Dealer hand dealt one up one down
# Options: Hit, Stand, Double Down, Split
# Dealer must stand on 17, draw until then
# If it's a draw, player gets bet back

require 'pry'
def e
  exit!
end


require_relative 'lib/blackjack_classes'

player = Player.new ("Vadim")
p player


d = Deck.new
h = Hand.new

binding.pry
