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
=end

module Validatable
  # thinking I'll put all my validation here
end

module Hand
  WINNING_NUMBER = 21

  def hit

  end

  def stay

  end

  def busted?

  end
end

class Player
  include Hand

  attr_accessor :hand, :total

  def initialize(total = 0)
    @hand = []
    @total = total
  end
end

class Dealer
  DEALER_STAY_AT = 17

  include Hand

  attr_accessor :hand, :total

  def initialize(total = 0)
    @hand = []
    @total = total
  end

  def deal

  end
end

class Deck
  SUITS = %w(D H S C)  # diamonds, hearts, spades, and clubs
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  FACE_CARD = %w(Jack Queen King)

  attr_accessor :cards

  def initialize
    @cards = shuffle.map { |card| card = Card.new(card[0], card[1]) }
    #SANITY CHECK
    @cards.each { |card| puts "#{card.value} of #{card.suit}" }
  end

  def shuffle
    SUITS.product(VALUES).shuffle
  end

  def deal(number_of_cards)
    hand = []
    hand << self.cards.shift(number_of_cards)
    hand
    @cards.each { |card| puts "#{card.value} of #{card.suit}" }
    # IT'S WORKING!
  end
end

class Card < Deck
  attr_reader :value, :suit

  def initialize(suit, value)
    @suit = suit    
    @value = value
  end

  def drawn?
    
  end
end

# Orchestration Engine
class TwentyOneGame
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
      show_initial_cards
      player_turn
      dealer_turn
      show_result
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end
  
  def deal_cards
    player.hand << deck.deal(2)
  end

  def show_initial_cards

  end
  
  def player_turn

  end

  def dealer_turn

  end

  def show_result

  end

  def play_again?

  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One!"
  end
end

game = TwentyOneGame.new
game.play
