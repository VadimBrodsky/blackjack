# Nouns:
#  - Player (human / delaer)
#  - Hand
#  - Card
#  - Deck
#  - Game

class Player
  attr_accessor :name

  def initialize(name)
    self.name = name
  end
end


class Card
  FACES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5,
          '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
          'jack' => 10, 'queen' => 10, 'king' => 10, 'ace' => [1, 11] }
  SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦', 'clubs' => '♣' }

  attr_reader :face, :suit

  def initialize(face, suit)
    @face = face if FACES.include?(face)
    @suit = suit if SUITS.include?(suit)
  end

  def self.all_cards
    FACES.keys.product(SUITS.keys)
  end
end


class Deck
  attr_reader :deck

  def initialize
    @deck = Card.all_cards.shuffle.map {|card| Card.new(card[0], card[1])}
  end

  def to_a
    deck.map {|c| [c.face, c.suit]}
  end
end
