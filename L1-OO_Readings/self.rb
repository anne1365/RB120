#SELF USED WHEN WE CALL AN INSTANCE METHOD FROM WITHIN THE CLASS
class Dog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.wight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end
end

sparky = Dog.new("Sparky", "12 inches", "10 lbs")
sparky.what_is_self

#SELF USED WHEN WE DEFINE CLASS METHODS
class MyAwesomeClass
  def self.this_is_a_class_method
  end
end


class GoodDog
  @@number_of_dogs = 0
  puts self

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs