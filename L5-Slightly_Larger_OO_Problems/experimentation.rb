module Walkable
  def say_hi(person)
    puts "Hi #{person}"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(name)
    @name = name.upcase!
    return 5
  end
end

class Interaction
  include Walkable

  attr_accessor :person

  def initialize
    @person = Person.new("Mike")
  end

  def greet(name)
    say_hi(name)
  end
end

a = Interaction.new
a.greet('Anne')


a = Person.new('Anne')
p a.name
a.name=('Bob')
p a.name