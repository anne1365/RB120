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