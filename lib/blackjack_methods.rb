require 'pry'

# BlackJack Data
CARDS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5,
          '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
          'jack' => 10, 'queen' => 10, 'king' => 10, 'ace' => [1, 11] }
SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦', 'clubs' => '♣' }
DECK = CARDS.keys.product(SUITS.keys)
BLACKJACK = 21
ACE_LIMIT = 11

# BlackJack Methods
def create_deck(deck)
  deck.shuffle
end

def give_cards_from(deck, number)
  deck.shift(number)
end

def say(message)
  puts "=> #{message}"
end

def print_hand_for(name = 'you', hand)
  if name == 'you'
    say('You hold in your hand:')
  else
    say("#{name} holds:")
  end
  hand.each do |card|
    say("#{card[0].capitalize} of #{card[1].capitalize}")
  end
end

def value_of(card, sum)
  if card.class == Array   # if the card value is an array it's an ace
    sum >= ACE_LIMIT ? card.first : card.last
  else
    card
  end
end

def sum_of(hand)
  sum = 0
  hand.each { |card| sum += value_of(CARDS[card.first], sum) }
  sum
end
