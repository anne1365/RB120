# ------------------------------------------------------------------------
# POLYMORPHISM IN CLASS INHERITANCE

class Animal
  def eat
    #generic eat method
  end
end

class Fish < Animal
  def eat
    # eating specific to fish
  end
end

class Cat < Animal
  def eat
    # eat implementation for a cat
  end
end

# In the code below it's evident that we can treat each of these classes
# as basically an object that can eat - this public interface lets us work
# with these types in the same way ever though the implementation of each
# eat method could be totally different

def feed_animal(animal)
  animal.eat
end


array_of_animals = [Animal.new, Fish.new, Cat.new]
array_of_animals.each { |animal| feed_animal(animal) }

# ---------------------------------------------------------------------------
# POLYMORPHISM IN DUCK TYPING
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    #implementation
  end
end

def Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end

# -----------------------------------------------------------------------------
# POLYMORPHISM IN ENCAPSULATION
class Dog
  attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n

    # self keyword is necessary so that Ruby knows we're accessing a method
    # and not initializing a local variable (as of Ruby 2.7 we can call private
    # methods w/ self as caller)
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private
    attr_writer :nickname
end

dog = Dog.new
dog.change_nickname("barny") # changed nickname to 'barny'
puts dog.greeting # => Barny says Woof Woof!

#--------------------------------------------------------------------------------