class Cat
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