=begin
Using the Card class from the previous exercise, create a Deck class that
contains all of the standard 52 playing cards. Use the following code to start
your work:

Copy Code
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
end
The Deck class should provide a #draw method to deal one card. The Deck should
be shuffled when it is initialized and, if it runs out of cards, it should reset
itself by generating a new set of 52 shuffled cards.
=end


class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :cards

  def initialize
    @cards = shuffle
  end

  def shuffle
    SUITS.product(RANKS).shuffle
  end

  def draw
    self.cards.shift
  end
end

class Card < Deck
  include Comparable
  attr_reader :rank, :suit
    
  HIERARCHY = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
  
  def <=>(other)
    HIERARCHY.index(rank) <=> HIERARCHY.index(other.rank)
  end

  def rank
    
  end

  def suit
    self[0]
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
drawn != drawn2 # Almost always.