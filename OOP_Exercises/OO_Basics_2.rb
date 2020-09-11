class Cat
  @@total = 0
  CAT_COLOR = 'orange'
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @@total += 1
  end

  def self.total
    @@total
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def rename(new_name)
    self.name = new_name
    # to modify name using name's setter method, we must prepend it with 'self' so ruby knows
    # we are referencing the setter method and not initializing a new local variable
  end

  def identity
    self
  end

  def personal_greeting
    puts "Hello! My name is #{name} and I'm an #{CAT_COLOR} cat!"
  end

  def to_s
    "I'm #{name}!"
  end
end

# kitty = Cat.new
# kitty.class.generic_greeting

# kitty = Cat.new("Sophie")
# sherlock = Cat.new("Sherlock")
# p kitty.name
# kitty.rename("Chloe")
# p kitty.name
# p kitty.identity

# Cat.generic_greeting
# sherlock.personal_greeting
# p Cat.total
# puts kitty





class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  def compare_secret(other_person)
    secret == other_person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)