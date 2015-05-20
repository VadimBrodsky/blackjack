require 'pry'

# BlackJack Data
CARDS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5,
          '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
          'jack' => 10, 'queen' => 10, 'king' => 10, 'ace' => [1, 11] }
SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦', 'clubs' => '♣' }
DECK = CARDS.keys.product(SUITS.keys)
BLACKJACK = 21
ACE_LIMIT = 11
DEALER_MAXIMUM = 17

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

def print_card(card)
  # +-------+  +-------+  +-------+
  # | 4     |  | 4     |  |*******|
  # |       |  |       |  |*******|
  # |   ♠   |  |   ♠   |  |*******|
  # |       |  |       |  |*******|
  # |       |  |       |  |*******|
  # +-------+  +-------+  +-------+

  horizontal_line = '+-------+'
  card_line       = '| #     |'
  vertical_line   = '|       |'
  suit_line       = '|   X   |'
  card_spacer     = '  '

  card_art = [horizontal_line, card_line, vertical_line, suit_line, vertical_line, vertical_line, horizontal_line]

  card_art.each do |item|
    puts ( item + card_spacer ) * 5
  end
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
  say("With the sum of #{sum_of(hand)}")
  puts '-------------'
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

def ask_hit_or_stay
  player_choice = nil
  loop do
    print 'Hit or Stay? (h/s): '
    player_choice = gets.chomp.downcase
    break if player_choice == 'h' || player_choice == 's'
  end
  player_choice
end

def hit(hand, deck)
  hand << give_cards_from(deck, 1).first
end

def bust?(hand)
  sum_of(hand) > BLACKJACK
end
