=begin
 RULES:
 - start w/ standard deck of playing cards
 - goal is to get as close to 21 as possible without going over
   - numbers 2-10 worth face value
   - jack, queen, and king worth 10
   - ace worth 1 or 11, depending on the player's hand's sum - if a player
     draws more than one ace, the next ace's value might be different from
     the first
 - game consists of a dealer and a player, each of whom start with 2 cards
 - the player can see one of the dealer's cards
 - player goes first
 - player can decide to 'hit' or 'stay'
   - hit -> player gets another card (can repeat as many times as player wants,
     until player stays or busts (loses))
   - stay -> ends the player's turn
 - dealer will hit until their total is at least 17, and then stay
 - once dealer stays, the player and dealer totals are compared
 - the total closest to 21 without going over wins
 - if dealer busts then player wins

 DESCRIPTION:
 Twenty-one is a card game in which the dealer and player seek to have total
 hands equalling, but not exceeding, twenty-one.

 - Player and dealer are initially dealt two cards from a standard deck
 - Player goes first, and can hit (be dealt another card) or stay (ending turn)
 - Dealer goes next, and will hit until their total is at least 17
 - If either player or dealer busts during their turn, the other player will win
 - If no one busts, the totals will be compared and the participant whose
   hand total is closer to 21 will win
 - if hand totals are the same it's a tie

NOUNS:
 - deck
 - card
 - player's hand
 - dealer's hand
 - player
 - dealer
 - participant
 - game
 - total

VERBS:
 - shuffle
 - deal
 - hit
 - stay
 - bust

ORGANIZED NOUNS & VERBS
 - Participant
    - hit
    - stay
    - busted?
    - total
 - Player
 - Dealer
    - deal
 - Deck
    - shuffle
    - deal
 - Card
    - drawn?
 - Game
    - play

CONCEPTUAL QUESTIONS:
 - can you hold state in a module?

DESIGN THOUGHTS:
 - I want to think more about whether my methods are divided into the
   appropriate classes
 - Currently a round doesn't immediately end when a participant either busts
   or reaches 21, and that's what should happen
 - need to do something about the hit method so that it works, and I can still
   keep the dealer and player functionality separate
 - incorporate the yaml <3 <3 <3
 - all the output text needs reworking before first draft is done
=end

module Displayable
  def display_divider
    puts "-------------------------------------------------"
  end

  def clear
    system('cls')
  end

  def joinor(array, punc = ', ', word = 'and')
    if array.count > 1
      last_element = array.pop
      "#{array.join(punc)} #{word} #{last_element}"
    else
      array[0]
    end
  end

  def display_welcome_message
    clear
    puts "Welcome to Twenty-One!"
    puts ""
  end

  def display_result
    case determine_winner
    when 'player' then puts "You win the round!"
    when 'dealer' then puts "Dealer wins the round!"
    else puts "It's a tie!"
    end
  end

  def display_play_again_message
    clear
    puts "Let's play again!"
    puts ""
  end

  def display_goodbye_message
    clear
    puts "Thanks for playing Twenty-One!"
  end
end

module Hand
  HIT = 'H'
  STAY = 'S'
  WINNING_NUMBER = 21

  def get_card_values(hand)
    hand.flatten.map(&:value)
  end

  # CYCLOMATIC & PERCEIVED COMPLEXITY TOO HIGH + TOO MANY LINES -- RECONCILE
  def determine_total(hand)
    sum = 0
    get_card_values(hand).each do |value|
      if ('1'..'10').include?(value)
        sum += value.to_i
      elsif ('JQK').include?(value)
        sum += 10
      elsif value == 'A' && sum <= 10
        sum += 11
      elsif value == 'A' && sum > 10
        sum += 1
      end
    end
    sum
  end

  def hit(hand)
    hand << deck.deal
    hand.flatten
  end

  def winner?(hand)
    determine_total(hand) == WINNING_NUMBER
  end

  def busted?(hand)
    determine_total(hand) > WINNING_NUMBER
  end
end

class Participant
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
    puts "Would you like to HIT (H) or STAY (S)?"
    answer = ''
    loop do
      answer = gets.chomp.upcase
      break if [HIT, STAY].include?(answer)
      puts "Error: Invalid response!"
    end
    answer
  end
end

class Dealer < Participant
  # Is there anything I should include here?
end

class Deck
  SUITS = %w(♦ ♣ ♠ ♥) # diamonds, hearts, spades, and clubs
  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  FACE_CARD = %w(Jack Queen King)

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

  def initialize
    reset_game
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
    return if player.winner?(player.hand)
    dealer_turn
    return if dealer.winner?(dealer.hand)
    display_result
  end

  def deal_cards
    player.hand << deck.deal(2).flatten
    dealer.hand << deck.deal(2).flatten
  end

  def show_cards
    player_cards = player.get_card_values(player.hand)
    puts "YOU HAVE:     #{joinor(player_cards)} (TOTAL: #{player.total})"

    dealer_cards = player.get_card_values(dealer.hand)
    puts "DEALER HAS:   #{joinor([dealer_cards.first, '?'])}"
    # (TOTAL: #{dealer.total})\n\n" # REMEMBER TO HIDE LAST # IN FINAL CODE
  end

  # ABCSize TOO HIGH + METHOD TOO LONG -- RECONCILE
  def player_turn
    loop do
      if player.winner?(player.hand)
        break puts "Your total is #{player.total} - YOU WIN :D :D!!"
      elsif player.busted?(player.hand)
        break puts "You busted!"
      else # player total < 21
        display_divider
        choice = player.hit_or_stay
        if choice == Player::HIT
          hit(player.hand)
          puts "\nYou chose to hit!"
          puts "Your new total is #{player.total}."
        elsif choice == Player::STAY
          break puts "\nYou stayed with a total of #{player.total}."
        end
      end
    end
  end

  # ABCSize TOO HIGH + METHOD TOO LONG -- RECONCILE
  def dealer_turn
    display_divider
    loop do
      if dealer.winner?(dealer.hand)
        break puts "Dealer's total is #{dealer.total} - THE DEALER WINS!"
      elsif dealer.busted?(dealer.hand)
        break puts "Dealer busted with a total of #{dealer.total}!"
      else # dealer total < 21
        if dealer.total < 17
          hit(dealer.hand)
          puts "The dealer chose to hit!"
        else
          break puts "Dealer chose to stay with a total of #{dealer.total}."
        end
      end
    end
    display_divider
  end

  # ABCSize & PERCEIVED/CYCLOMATIC COMPLEXITY TOO HIGH + METHOD TOO LONG -- RECONCILE
  def determine_winner
    player_busted = player.busted?(player.hand)
    dealer_busted = dealer.busted?(dealer.hand)

    if player_busted && dealer_busted || player.total == dealer.total
      'tie'
    elsif (player.total > dealer.total && !player_busted) || dealer_busted
      'player'
    elsif (player.total < dealer.total && !dealer_busted) || player_busted
      'dealer'
    end
  end

  # METHOD TOO LONG -- RECONCILE
  def play_again?
    puts ""
    pause
    clear
    puts "Would you like to play again? (y/n)"
    answer = ""
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Error: Please input 'y' or 'n'!"
    end
    answer == 'y'
  end

  def pause
    puts "Hit enter to continue!"
    gets.chomp
    clear
  end

  def reset_game
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end
end

game = TwentyOneGame.new
game.play
