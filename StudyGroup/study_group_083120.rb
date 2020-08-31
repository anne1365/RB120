=begin# Classes and objects

60% concepts and about 40% code
last question is long 0 about code - writing a program using content
- wiritng up examples for each concept
# Use attr_* to create setter and getter methods
# How to call setters and getters
# Instance methods vs. class methods
# Referencing and setting instance variables vs. using getters and setters
# Class inheritance, encapsulation, and polymorphism
# Modules
# Method lookup path
# self
# Calling methods with self
# More about self
# Reading OO code
# Fake operators and equality
# Truthiness
# Working with collaborator objects

# Classes and objects
# Use attr_* to create setter and getter methods
# How to call setters and getters
# Instance methods vs. class methods
# Referencing and setting instance variables vs. using getters and setters
# Class inheritance, encapsulation, and polymorphism
# Modules
# Method lookup path
# self
# Calling methods with self
# More about self
# Reading OO code
# Fake operators and equality
# Truthiness
# Working with collaborator objects

# I. Polymorphism
#     A. When different objects respond to the same invocation because they share the same method name but may have different implementation.
#     B. Often involves class inheritance but can also involve duck typing.

# Class Inheritance
# class Mammal
#   def move
#     "Running!"
#   end

#   def eat
#     "Eating!"
#   end
# end

# class Dog < Mammal
# end

# class Cat < Mammal
# end

# class Kangaroo < Mammal
#   def move
#     "Hopping!"
#   end
# end

# [Dog.new, Cat.new, Kangaroo.new].each { |mammal| puts mammal.move }

#Duck typing
# -Duck typing doesn’t concern itself with the class of an object but only what methods are available on the object.
# -“If it quacks like a duck, then we can treat it like a duck”.
class Dog
  def move
    "Running!"
  end
end

class Kangaroo
  def move
    "Hopping!"
  end
end

class Car
  def move
    "Vroom!"
  end
end

[Dog.new, Kangaroo.new, Car.new].each { |object| puts object.move }


class Desk 
  def initialize 
    @color = 'white' 
  end 
  
  def upcase_color
    color.upcase
  end 
  
  private
  
  def color
    @color.capitalize 
  end 
  
  def color=(new_color)
    @color = new_color 
  end 
  
end 

my_desk = Desk.new 

# p my_desk.upcase_color
# p my_desk.color
# your_desk = Desk.new 


=end

class Ancestors
  def bob
    self
  end
  
  def self.hello
    "#{self.ancestors[2]} class"
  end
end

class Humans < Ancestors
  def hello
    "ancestors class"
  end
end

class Persons < Humans
  def who_am_i
    puts "I am the #{bob.class.hello}"
    #I am the ancestors class
  end
end

bob = Persons.new
bob.who_am_i