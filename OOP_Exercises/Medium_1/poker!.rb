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

  def draw(number_of_cards)
    dealt_cards = []

    number_of_cards.times do
      break reset if cards.empty?
      dealt_cards << cards.shift
    end

    dealt_cards
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def reset
    self.cards = shuffle.map { |card| Card.new(card[0], card[1]) }
  end
end

class Card
  include Comparable
  attr_accessor :rank, :suit

  HIERARCHY = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

class PokerHand
  ROYAL_FLUSH = ['10', 'Jack', 'Queen', 'King', 'Ace']

  attr_accessor :cards

  def initialize(deck)
    @deck = deck
    @cards = deck.draw(5)
  end

  def print
    cards.each { |card| puts "#{card.rank} of #{card.suit}" }
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
    ranks == ROYAL_FLUSH && flush?
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    count_repeating_cards(4, 1)
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    Deck::RANKS.join.include?(ranks.join)
  end

  def three_of_a_kind?
    count_repeating_cards(3, 1)
  end

  def two_pair?
    count_repeating_cards(2, 2)
  end

  def pair?
    count_repeating_cards(2, 1)
  end

  def count_repeating_cards(repeat_number, repeat_occurrences)
    Deck::RANKS.count do |rank|
      cards.count { |card| card.rank == rank } == repeat_number
    end == repeat_occurrences
  end

  def ranks
    cards.sort! do |a, b|
      Card::HIERARCHY.index(a.rank) <=> Card::HIERARCHY.index(b.rank)
    end
    cards.map { |card| card.rank.to_s }
  end

  def suits
    cards.map(&:suit)
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
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
