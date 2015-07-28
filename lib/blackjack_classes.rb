# Nouns:
#  - Player (human / delaer)
#  - Hand
#  - Card
#  - Deck
#  - Game

class Player
  attr_accessor :name, :hand, :status
  RENDER_DELAY = 0.3

  def initialize(name)
    self.name = name
    self.hand = Hand.new
    self.status = :playing
  end

  def num_of_cards
    hand.num_in_hand
  end

  def hit(card)
    hand.hit(card)
    update_status
  end

  def value
    hand.value
  end

  def delay
    sleep RENDER_DELAY
  end

  def print_hand
    puts "\n#{name} holds:"
    hand.cards.each { |c| delay; puts " #{c}" }
    delay
    puts "TOTAL: #{hand.value}"
    sleep RENDER_DELAY * 2
  end

  def update_status
    self.status = :bust if hand.bust?
    self.status = :blackjack if hand.blackjack?
  end

  def <=>(other)
    hand.value <=> other.hand.value
  end
end

class Dealer < Player
  DEALER_LIMIT = 17

  def print_hand
    if hand.num_in_hand < 3
      hide_one_card
    else
      print_all_cards
    end
  end

  def hide_one_card
    puts "\n#{name} holds:"
    delay
    puts " #{hand.cards.first}"
    delay
    puts ' XX'
  end

  def print_all_cards
    puts "\n#{name} holds:"
    hand.cards.each { |c| delay; puts " #{c}" }
    delay
    puts "TOTAL: #{hand.value}\n"
    sleep RENDER_DELAY * 2
  end

  def update_status
    super
    self.status = :stand if hand.value >= DEALER_LIMIT && hand.value < Blackjack::BLACKJACK
  end
end

class Card
  FACES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
            '8' => 8, '9' => 9, '10' => 10, 'jack' => 10, 'queen' => 10,
            'king' => 10, 'ace' => [1, 11] }
  SUITS = { 'spades' => '♠', 'hearts' => '♥', 'diamonds' => '♦',
            'clubs' => '♣' }

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

  def to_s
    if face == '10'
      "#{SUITS[suit]}#{face[0..1].capitalize }"
    else
      "#{SUITS[suit]}#{face.chr.capitalize }"
    end
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = Card.all_cards.shuffle.map { |card| Card.new(card[0], card[1]) }
  end

  def to_a
    cards.map { |c| [c.face, c.suit] }
  end

  def draw_card
    @cards.shift(1).first
  end

  def draw_cards(num = 1)
    @cards.shift(num)
  end

  def num_in_deck
    cards.count
  end
end

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit(card)
    @cards << card
  end

  def num_in_hand
    cards.count
  end

  def value
    if aces?
      value_with_aces
    else
      value_without_aces
    end
  end

  def count_aces
    cards.count { |c| c.face == 'ace' }
  end

  def aces?
    count_aces > 0
  end

  def value_without_aces
    cards.select { |c| c.face != 'ace' }.map(&:value).reduce(:+)
  end

  def value_with_aces
    val = value_without_aces
    val ||= 0
    aces = count_aces
    aces.times { val += val >= 11 ? 1 : 11 }
    val
  end

  def bust?
    value > Blackjack::BLACKJACK
  end

  def blackjack?
    value == Blackjack::BLACKJACK
  end
end

class Blackjack
  attr_reader :deck

  BLACKJACK = 21

  def initialize
    print_welcome_message
    @deck = Deck.new
    @player = Player.new(ask_for_name)
    @dealer = Dealer.new('Dealer')
    play_game
  end

  def print_welcome_message
    system 'clear'
    puts 'Welcome to BlackJack!'
  end

  def ask_for_name
    print 'What is your name? '
    gets.chomp.capitalize
  end

  def play_game
    loop do
      deal_cards
      player_loop
      dealer_loop
      determine_winner([@player, @dealer])
      reset_game
      break if ask_play_or_quit == 'q'
    end
    puts 'Bye.'
  end

  def deal_cards
    2.times do
      @player.hit(@deck.draw_card)
      @dealer.hit(@deck.draw_card)
    end
    print_game_state
  end

  def player_hit_verbose(player)
    puts "\n=> #{player.name} Draws a Card:"
    player.hit(@deck.draw_card)
    player.print_hand
  end

  def print_game_state
    @player.print_hand
    @dealer.print_hand
  end

  def player_loop
    while @player.status == :playing
      if ask_hit_or_stay == 'h'
        player_hit_verbose(@player)
      else
        @player.status = :stand
      end
    end
  end

  def ask_hit_or_stay
    player_choice = nil
    loop do
      print "\nHit or Stay? (h/s): "
      player_choice = gets.chomp.downcase
      break if player_choice == 'h' || player_choice == 's'
    end
    player_choice
  end

  def ask_play_or_quit
    player_choice = nil
    loop do
      print "\nPlay or Quit? (p/q): "
      player_choice = gets.chomp.downcase
      break if player_choice == 'p' || player_choice == 'q'
    end
    player_choice
  end

  def dealer_loop
    dealer_open_hand

    if @player.status != :stand && @dealer.status == :playing
      @dealer.status = :stand
    end

    while @dealer.status == :playing
      if @dealer.hand.value > @player.hand.value
        @dealer.status = :stand
      else
        player_hit_verbose(@dealer)
      end
    end
  end

  def dealer_open_hand
    puts "\n=> Dealer Opens Hand:"
    @dealer.print_all_cards
  end

  def print_winner(player)
    puts "\n=> #{player.name} won!"
  end

  def all_busted?(players)
    players.length == 0
  end

  def one_player_left?(players)
    players.length == 1
  end

  def self.remove_busted_players!(players)
    players.delete_if { |p| p.status == :bust }
  end

  def self.highest_value(players)
    players.max.value
  end

  def self.top_players(players)
    value = Blackjack.highest_value(players)
    players.select { |p| p.value == value }
  end

  def top_players_tied?(players)
    Blackjack.top_players(players).length > 1
  end

  def self.tie_breaker(players)
    tied_players = Blackjack.top_players(players)
    higest_num_cards = tied_players.max { |p1, p2| p1.num_of_cards <=> p2.num_of_cards }.num_of_cards
    tied_players.delete_if { |p| p.num_of_cards < higest_num_cards }
    tied_players.length == 1 ? tied_players.first : nil
  end

  def determine_winner(players)
    players.sort!
    Blackjack.remove_busted_players!(players)

    if all_busted?(players)
      puts "\n=> All busted, no winner :("
    elsif one_player_left?(players)
      print_winner(players.last)
    elsif top_players_tied?(players)
      if Blackjack.tie_breaker(players)
        print_winner(Blackjack.tie_breaker(players))
      else
        puts "\n=> It's a Draw!"
      end
    end
  end

  def reset_game
    @deck = Deck.new
    @player = Player.new(@player.name)
    @dealer = Dealer.new(@dealer.name)
  end
end
