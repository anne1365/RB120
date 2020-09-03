# class Cat
#   def initialize(name)
#     @name = name
#     puts name
#   end

#   def name        # In ruby getters and setters are named after the        
#     @name         # instance variables they work with, rather than 'get_name'
#   end             # or 'set_name'

#   def name=(name)
#     @name = name
#   end
# end


# sherlock = Cat.new("Sherlock")
# puts sherlock.name

# # two ways to invoke setter method - first is syntactical sugar
# puts sherlock.name = "Sherlock my boiii"
# puts sherlock.name=("Sherlock")

# --------------------------------------------------------------------------------------------------

class Dog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{@name} says arf!"
  end

#  In the change info method below, we could access the instance variables
#  directly in order to change them (@name = n), but if we try and call the 
#  setter method to change the instance varaible (name = n), this doesn't work.
#  Ruby interprets this as the initialization of a local variable, and the
#  value of our name instance variable is not changed. To fix this, we can use
#  self, which lets Ruby know that the 'name' we're referring to is a method
#  and not a variable (self.name = n).

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = Dog.new("Sparky", '12 inches', '10 lbs')
puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info

# ------------------------------------------------------------------------


