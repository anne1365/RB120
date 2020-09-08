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
  
# if we call super like this, we're calling super with no arguments, but
# the initialize method here takes one argument, super automatically forwards
# the arguments that were passed to the method from which super is called

    @color = color
  end

  def info
    puts "#{self.name} #{self.color}"
  end
end


class BadDog < Animal 
  def initialize(age, name)
    super(name)

# if we call super like this, we pass the argument passed to super to the
# superclass

    @age = age
  end
end


class Bear < Animal
  def initialize(color)
    super()

# if we call super like this - with no parentheses - it will call the 
# method in the superclass with no arguments - this is the safest way to
# call a method in our superclass that takes no arguments

    @color = color
  end
end



sparky = GoodDog.new("brown")
p sparky.info # => both name and color = brown

p BadDog.new(2, "bear") # => name = bear & age = 2
# this is because we sent an argument to superclass

bear = Bear.new("black")


