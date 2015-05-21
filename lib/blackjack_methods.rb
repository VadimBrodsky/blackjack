require 'pry'

# BlackJack Data
CARDS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5,
          '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
          'jack' => 10, 'queen' => 10, 'king' => 10, 'ace' => [1, 11] }
SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦', 'clubs' => '♣' }
DECK = CARDS.keys.product(SUITS.keys)

# Game Constants
BLACKJACK = 21
ACE_LIMIT = 11
DEALER_MAXIMUM = 17

# Card Drawing
HORIZONTAL_LINE = '+-------+'
VERTICAL_LINE   = '|       |'
BACKFACE_LINE   = '|*******|'
CARD_SPACER     = '  '

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

def line_break
  puts ''
end

def draw_backface_card
  [HORIZONTAL_LINE, BACKFACE_LINE, BACKFACE_LINE, BACKFACE_LINE,
   BACKFACE_LINE, BACKFACE_LINE, HORIZONTAL_LINE]
end

# Accepts input in the card format ["ace", "spades"]
# Returns array
def draw_card(card)
  if card
    number_line = if card[0] == '10'
                    "| #{card[0]}    |"
                  else
                    "| #{card[0][0].upcase}     |"
                  end
    suit_line   = "|   #{SUITS[card[1]]}   |"
    [HORIZONTAL_LINE, number_line, VERTICAL_LINE, suit_line,
     VERTICAL_LINE, VERTICAL_LINE, HORIZONTAL_LINE]
  else
    draw_backface_card
  end
end

# Accepts input in the hand format [["ace", "spades"], ["4", "hearts"]]
# Returns 2D array
def draw_hand(hand)
  cards = []
  hand.each { |card| cards << draw_card(card) }
  cards
end

# Accepts input in the hand format [["ace", "spades"], ["4", "hearts"]]
def print_hand_as_cards(hand)
  drawing = draw_hand(hand)
  number_of_cards = drawing.length
  number_of_card_segments = drawing.first.length

  number_of_card_segments.times do |card_segment|
    number_of_cards.times do |index|
      print drawing[index][card_segment]
      print CARD_SPACER
    end
    print "\n"
  end
end

def print_hand_for(name, hand)
  message = "#{name} holds: "
  hand.each_with_index do |card, index|
    message += "#{card[0].capitalize} of #{card[1].capitalize}"
    message += ', ' unless index == hand.length - 1
  end
  # p hand
  say(message)
end

def print_game_state(dealer_hand, player_hand, player_name,
  message = 'Welcome to BlackJack!')
  system('clear')
  puts "#{message}\n\n"
  puts '------ DEALER ------'
  print_hand_as_cards(dealer_hand)
  line_break
  puts "------ #{player_name.upcase} ------"
  print_hand_as_cards(player_hand)
  line_break
  print_hand_for(player_name, player_hand)
  say("Sum of: #{sum_of(player_hand)}")
  line_break
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

def name_of_winner(player_hand, dealer_hand, name = 'Player')
  if bust?(dealer_hand)
    name
  elsif bust?(player_hand)
    'Dealer'
  elsif sum_of(player_hand) < sum_of(dealer_hand)
    'Dealer'
  elsif sum_of(player_hand) > sum_of(dealer_hand)
    name
  elsif sum_of(player_hand) == sum_of(dealer_hand)
    false
  end
end

def print_winner(name)
  if name
    puts "#{name} wins!"
  else
    puts 'It\'s a tie!'
  end
end

def ask_play_again
  player_choice = nil
  loop do
    print 'Play Again? (y/n): '
    player_choice = gets.chomp.downcase
    break if player_choice == 'y' || player_choice == 'n'
  end
  player_choice
end
