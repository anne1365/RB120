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


module Hand
  HIT = 'H'
  STAY = 'S'
  WINNING_NUMBER = 21

  def get_card_values(hand)
    hand.flatten.map(&:value)
  end

  def hit; end # IMPLEMENT

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

  def busted?(hand)
    determine_total(hand) > WINNING_NUMBER
  end
end





class Player
  include Hand

  attr_accessor :hand

  def initialize(total = 0)
    @hand = []
    @total = total
  end

  def total
    determine_total(hand)
  end

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

  def turn # NEED IMPLEMENTATION
    loop do
      choice = hit_or_stay
      if choice == HIT
        hit(hand)
        break puts "You busted! TOTAL #{total}" if busted?(hand)
        puts "You hit! Your new total is #{total}."
      elsif choice == STAY
        break puts "You stayed with a total of #{total}!"
      end
    end
  end
end





class Dealer
  include Hand

  attr_accessor :hand

  def initialize(total = 0)
    @hand = []
    @total = total
  end

  def total
    determine_total(hand)
  end

  def turn # NEED IMPLEMENTATION
    loop do
      break puts "Dealer stayed with a total of #{total}." if total >= 17
      hit(hand)
      break puts "Dealer busted (TOTAL: #{total})! YOU WIN!" if busted?(hand)
      puts "Dealer hit (NEW TOTAL: #{total})!"
    end
  end
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
  include Validatable

  HIT = 'H'
  STAY = 'S'

  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    display_welcome_message
    loop do
      deal_cards
      show_cards
      player.turn
      dealer.turn
      show_result
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def clear
    system('cls')
  end

  def joinor(array, punc = ', ', word = 'and')
    if array.count > 1
      last_element = array.delete(array.last)
      "#{array.join(punc)} #{word} #{last_element}"
    else
      array[0]
    end
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end

  def deal_cards
    player.hand << deck.deal(2).flatten
    dealer.hand << deck.deal(2).flatten
  end

  def show_cards
    player_cards = player.get_card_values(player.hand)
    puts "YOU HAVE: #{joinor(player_cards)} (TOTAL: #{player.total})"

    dealer_cards = player.get_card_values(dealer.hand)
    puts "DEALER HAS: #{joinor(dealer_cards)} (TOTAL: #{dealer.total})" # REMEMBER TO HIDE LAST # IN FINAL CODE
  end

  def hit(hand) # SEE IF I CAN'T MOVE THIS TO HAND MODULE
    hand << deck.deal
    hand.flatten
  end

  def show_result
    case determine_winner
    when 'player' then puts "You win the round!"
    when 'dealer' then puts "Dealer wins the round!"
    else puts "It's a tie!"
    end
  end

  def determine_winner # LOGIC DOESN'T ACCOUNT FOR WHETHER PARTICIPANT HAS BUSTED
    if player.total > dealer.total
      'player'
    elsif player.total < dealer.total
      'dealer'
    else
      'tie'
    end
  end

  def play_again?
    puts "Would you like to play again?"
    # IMPLEMENT REST LATER
    puts "Maybe later :P"
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One!"
  end
end

game = TwentyOneGame.new
game.play
