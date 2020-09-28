class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :cards

  def initialize
    reset
  end

  def shuffle
    RANKS.product(SUITS).shuffle
  end

  def draw
    reset if cards.empty?
    cards.shift 
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def reset
    self.cards = shuffle.map { |card| card = Card.new(card[0], card[1]) }
  end
end

class Card
  # include Comparable
  attr_accessor :rank, :suit

  # HIERARCHY = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  # def to_s
  #   "#{rank} of #{suit}"
  # end

  # def <=>(other)
  #   HIERARCHY.index(rank) <=> HIERARCHY.index(other.rank)
  # end
end

class PokerHand
  attr_accessor :hand

  def initialize(deck)
    @deck = deck
    @hand = []
    
    5.times { hand << deck.draw }
  end

  def print
    hand.each { |card| puts "#{card.rank} of #{card.suit}" }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
  end

  def straight_flush?
  end

  def four_of_a_kind?
    Deck::RANKS.each do |rank|
      hand.count { |card| card.rank == rank } == 4 
    end == 1
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
  end

  def straight?
  end

  def three_of_a_kind?
    Deck::RANKS.count do |rank|
      hand.count { |card| card.rank == rank } == 3 
    end == 1
  end

  def two_pair?
    Deck::RANKS.count do |rank|
      hand.count { |card| card.rank == rank } == 2 
    end == 2
  end

  def pair?
    Deck::RANKS.count do |rank|
      hand.count { |card| card.rank == rank } == 2 
    end == 1
  end 
end

# TESTING, TESTING
hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts "\nHand should be Royal Flush:"
puts hand.evaluate# == 'Royal flush'
puts

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts "Hand should be Straight Flush:"
puts hand.evaluate# == 'Straight flush'
puts

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts "Hand should be Four of a kind:"
puts hand.evaluate# == 'Four of a kind'
puts

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts "Hand should be Full House"
puts hand.evaluate# == 'Full house'
puts

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts "Hand should be Flush:"
puts hand.evaluate# == 'Flush'
puts

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts "Hand should be Straight:"
puts hand.evaluate# == 'Straight'
puts

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts "Hand should be Straight:"
puts hand.evaluate# == 'Straight'
puts

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts "Hand should be Three of a kind:"
puts hand.evaluate# == 'Three of a kind'
puts

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts "Hand should be a Two pair:"
puts hand.evaluate# == 'Two pair'
puts

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts "Hand should be a pair:"
puts hand.evaluate# == 'Pair'
puts

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts "Hand should be a High card:"
puts hand.evaluate# == 'High card'
puts