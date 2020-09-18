module Walkable
  def say_hi(person)
    puts "Hi #{person}"
  end
end

class Person
  include Walkable

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Interaction
  include Walkable

  attr_accessor :person

  def initialize
    @person = Person.new("Mike")
  end

  
end

a = Interaction.new
a.say_hi(a.person.name)