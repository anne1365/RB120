module Displayable
  require 'yaml'
  TEXT = YAML.load_file('twenty_one_config.yml')

  # UTILITY METHODS
  def display_divider
    puts "----------------------------------------"
  end

  def clear
    system('cls')
  end

  def pause
    puts "Hit enter to continue!"
    gets.chomp
    clear
  end

  def joinor(array, punc = ', ', word = 'and')
    if array.count > 1
      last_element = array.pop
      "#{array.join(punc)} #{word} #{last_element}"
    else
      array[0]
    end
  end

  # WELCOME MESSAGE
  def display_welcome_message
    clear
    puts TEXT[:welcome]
  end

  # GAMEPLAY MESSAGES
  def display_hit_or_stay_prompt
    puts TEXT[:hit_or_stay]
  end

  def display_current_total_message(total)
    puts ""
    puts "              YOUR CURRENT TOTAL: #{total}"
  end

  def display_player_hit_message(total)
    puts "You chose to hit!"
    puts "Your new total is #{total}."
  end

  def display_player_stay_message(total)
    puts "You stayed with a total of #{total}."
  end

  def display_player_busted_message
    puts TEXT[:player_busted]
  end

  def display_dealer_hit_message
    puts "The dealer chose to hit!"
  end

  def display_dealer_stay_message(total)
    puts "Dealer chose to stay with a total of #{total}."
  end

  def display_dealer_busted_message
    puts TEXT[:dealer_busted]
  end

  # OUTCOME MESSAGES
  def display_result
    case determine_winner
    when 'player' then puts TEXT[:player_won]
    when 'dealer' then puts TEXT[:dealer_won]
    else puts TEXT[:tie]
    end
  end

  # PLAY AGAIN MESSAGES
  def display_play_again_prompt
    puts ""
    pause
    clear
    puts TEXT[:play_again]
  end

  def display_play_again_error
    puts "Error: Please input 'y' or 'n'!"
  end

  def display_play_again_message
    clear
    puts TEXT[:lets_play_again]
  end

  # GOODBYE MESSAGE
  def display_goodbye_message
    clear
    puts TEXT[:thanks_for_playing]
  end
end

module Hand
  HIT = 'H'
  STAY = 'S'
  WINNING_NUMBER = 21

  def get_card_values(hand)
    hand.flatten.map(&:value)
  end

  def determine_total(hand)
    sum = 0

    get_card_values(hand).each do |value|
      sum += value.to_i if ('1'..'10').include?(value)
      sum += 10 if ('JQK').include?(value)
      sum += determine_ace_value(sum) if value == 'A'
    end

    sum
  end

  def determine_ace_value(sum)
    if sum <= 10
      11
    else
      1
    end
  end

  def hit(hand)
    hand << deck.deal
    hand.flatten
  end

  def busted?(hand)
    determine_total(hand) > WINNING_NUMBER
  end
end

class Participant
  include Displayable
  include Hand

  attr_accessor :hand
  attr_writer :total

  def initialize(total = 0)
    @hand = []
    @total = total
  end

  def total
    determine_total(hand)
  end
end

class Player < Participant
  def hit_or_stay
    display_hit_or_stay_prompt

    answer = ''
    loop do
      answer = gets.chomp.upcase
      break if [HIT, STAY].include?(answer)
      puts "Error: Invalid response!"
    end

    answer
  end
end

class Dealer < Participant; end

class Deck
  SUITS = %w(♦ ♣ ♠ ♥) # diamonds, hearts, spades, and clubs
  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_accessor :cards

  def initialize
    @cards = shuffle.map { |card| Card.new(card[0], card[1]) }
  end

  def shuffle
    SUITS.product(VALUES).shuffle
  end

  def deal(number_of_cards = 1)
    hand = []
    hand << cards.shift(number_of_cards)
    hand
  end
end

class Card < Deck
  attr_reader :value, :suit

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end

# ORCHESTRATION ENGINE
class TwentyOneGame
  include Displayable
  include Hand

  HIT = 'H'
  STAY = 'S'
  DEALER_STAY_AT = 17

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    display_welcome_message

    loop do
      single_turn
      break unless play_again?
      reset_game
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  attr_accessor :player, :dealer, :deck

  def single_turn
    deal_cards
    show_cards
    player_turn
    return if player_busted?
    dealer_turn
    return if dealer_busted?
    display_result
  end

  def deal_cards
    player.hand << deck.deal(2).flatten
    dealer.hand << deck.deal(2).flatten
  end

  def show_cards
    player_cards = player.get_card_values(player.hand)
    puts "YOU HAVE:     #{joinor(player_cards)}"

    dealer_cards = player.get_card_values(dealer.hand)
    puts "DEALER HAS:   #{joinor([dealer_cards.first, '?'])}"
  end

  def player_turn
    loop do
      break display_player_busted_message if player_busted?
      display_current_total_message(player.total)
      unless player.hit_or_stay == Player::HIT
        break display_player_stay_message(player.total)
      end

      hit(player.hand)
      display_player_hit_message(player.total)
    end
  end

  def dealer_turn
    loop do
      break display_dealer_busted_message if dealer_busted?

      unless dealer.total < DEALER_STAY_AT
        break display_dealer_stay_message(dealer.total)
      end

      hit(dealer.hand)
      display_dealer_hit_message
    end
  end

  def player_busted?
    player.busted?(player.hand)
  end

  def dealer_busted?
    dealer.busted?(dealer.hand)
  end

  def determine_winner
    if tie?
      'tie'
    elsif player_won?
      'player'
    elsif dealer_won?
      'dealer'
    end
  end

  def player_won?
    player.total > dealer.total
  end

  def dealer_won?
    dealer.total > player.total
  end

  def tie?
    player.total == dealer.total
  end

  def play_again?
    display_play_again_prompt

    answer = ""
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      display_play_again_error
    end

    answer == 'y'
  end

  def reset_game
    player.hand = []
    dealer.hand = []
    @deck = Deck.new
  end
end

game = TwentyOneGame.new
game.play
