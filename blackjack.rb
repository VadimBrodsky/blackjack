# BlackJack

require 'pry'
require_relative 'lib/blackjack_methods'

CARDS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦', 'clubs' => '♣' }

puts 'Welcome to BlackJack!'
p CARDS
p SUITS
