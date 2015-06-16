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

  def value
    FACES[face]
  end

  def self.all_cards
    FACES.keys.product(SUITS.keys)
  end
end


class Deck
  attr_reader :cards

  def initialize
    @cards = Card.all_cards.shuffle.map {|card| Card.new(card[0], card[1])}
  end

  def to_a
    cards.map {|c| [c.face, c.suit]}
  end

  def draw_card
    @cards.delete(cards.first)
  end
end


class Hand
  attr_reader :cards

  def initialize
    @cards = []
    @value = 0
  end

  def hit(card)
    @cards << card
  end

  def value
    if have_aces?
      value_with_aces
    else
      value_without_aces
    end
  end

  def count_aces
    cards.select{|c| c.face == 'ace'}.length
  end

  def have_aces?
    count_aces > 0
  end

  def value_without_aces
    cards.select{|c| c.face != 'ace' }.map{|c| c.value }.reduce(:+)
  end

  def value_with_aces
    val = value_without_aces
    val ||= 0
    aces = count_aces
    aces.times { val += val >= 11 ? 1 : 11 }
    val
  end


end
