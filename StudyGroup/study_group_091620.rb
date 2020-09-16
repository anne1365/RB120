class Shoe
  attr_accessor :size, :color, :type
  
  CLEAN = true 

  def initialize(size, color, type)
    @size = size
    @color = color
    @type = type
  end

  def lace
    "Lace up your #{type}, and let's go!"
  end

  def put_on
    "I'm wearing #{color} #{self.class}."
  end
end

class Sneakers < Shoe
end

class Boots < Shoe
end

class Sandals < Shoe
  attr_reader :laces
  
  def initialize(size, color, type, laces=false)
    super(size, color, type)
    @laces = laces
  end
  
  
  def lace
    if laces
      super
    else
      puts "These #{self.class} don't have laces!"
    end
  end
  

end


converse = Sneakers.new(8, "black", "Converse")
hiking_boots = Boots.new(12, "brown", "hiking boots")
flip_flops = Sandals.new(7, "purple", "flip_flops")

p converse.lace
p hiking_boots.lace
p flip_flops.lace
p converse.put_on

gladiator_sandals = Sandals.new(9, "gold", "gladiator sandals", true)

puts 
puts gladiator_sandals.lace #--Lace up you sandals and lets go 

#---------------------------------
class Cat
  attr_accessor :fav_toy
  
  def initialize(fav_toy)
    @fav_toy = fav_toy
  end
end

class Dragon 
  def initialize(fav_toy)
    @fav_toy = fav_toy
  end
end 

class FavoriteToy
  def play 
    puts "The #{self.class} is playing with their favorite toy!"
  end 
end

toy = FavoriteToy.new
cat = Cat.new(toy)
cat.fav_toy.play
draggy = Dragon.new(FavoriteToy.new)
draggy.fav_toy.play 


#---------------------------------------------
# namespace resolution operator: an operator that is used as a gateway into another scope to access constants/classes defined in that scope 

class Plant 
  FLOWERS = 'big'
end 

# p Plant::FLOWERS

module Window
  p Plant::FLOWERS
  OPEN = true
  
  
end

class Shelf
  include Window
  p Plant::FLOWERS
  # p Window::OPEN
  p OPEN
end 

module Computer 

  class Screen 
    def initialize 
      puts "I'm a computer screen"
    end 
  end 
end 

class Screen 
end 

Computer::Screen.new

