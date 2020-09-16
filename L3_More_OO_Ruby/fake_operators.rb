# COMPARISON
class Person
  attr_accessor :name, :age

  def initialize(name,age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)

puts "bob is older than kim" if bob > kim
puts "bob is older than kim" if bob.>(kim) # Same method call, different syntax

# puts "bob is older than kim" if bob < kim  # => NoMethodError
# We don't get '<' as a freebie when we define '>' - they must each be defined

#SHIFT METHODS
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push(person)
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)

cowboys << emmitt
p cowboys.members
