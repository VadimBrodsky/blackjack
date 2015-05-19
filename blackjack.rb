# BlackJack

require 'pry'
require_relative 'lib/blackjack_methods'

CARDS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5,
          '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
          'jack' => 10, 'queen' => 10, 'king' => 10, 'ace' => [1, 10] }
SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦', 'clubs' => '♣' }
DECK = CARDS.keys.product(SUITS.keys)

puts 'Welcome to BlackJack!'
# p CARDS
# p SUITS
p DECK.count
