class Pet
  attr_reader :pet_type, :pet_name

  def initialize(pet_type, pet_name)
    @pet_type = pet_type
    @pet_name = pet_name
  end

  def to_s
    "a #{pet_type} named #{pet_name}"
  end
end


class Shelter
  @@adoptions = {}

  def print_adoptions
    @@adoptions.each do |owner, pets|
      puts "#{owner.name} has adopted the following pets: "
      pets.each { |pet| puts pet }
      puts
    end
  end

  def adopt(name, pet_name)
    if @@adoptions.has_key?(name)
      @@adoptions[name] << pet_name
    else
      @@adoptions[name] = [pet_name]
    end
  end
end


class Owner < Shelter
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def number_of_pets
    @@adoptions[self].size
  end
end



butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

=begin
OUTPUT: 

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
=end


# We need a Pet class, that includes an initialize method containing a type
# of pet parameter and a name parameter

# we need an owner class that includes one parameter for the name of the owner

# we need a shelter class that includes an instance method adopt, which allows 
# an owner (first parameter) to adopt a pet (second parameter). We also need a 
# instance method print adoptions, that prints out who has adopted what pets 
# to keep track of this info we'll need a class variable

# we need a class method, probably in the owner class, that will keep track of
# the number of pets an owner has

# DRAW IT OUT

# LS SOLUTION
class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end


class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end


class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end


