class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end


class GoodDog < Animal
  attr_accessor :color
  
  def initialize(color)
    super
    @color = color
  end

  def info
    puts "#{self.name} #{self.color}"
  end
end


class BadDog < Animal 
  def initialize(age, name)
    super(name)
    @age = age
  end
end



sparky = GoodDog.new("brown")
sparky.info # => both name and color = brown

p BadDog.new(2, "bear") # => name = bear & age = 2
# this is because we sent an argument to superclass


