# str1 = 'cat'
# str2 = 'cat'
# puts str1 == str2
# puts str1.equal?(str2)

#DEFAULT IMPLEMENTATION - same as .equal?
class Person
  attr_accessor :name
end

bob = Person.new
bob.name = 'bob'

bob2 = Person.new
bob2.name = 'bob'

bob == bob2

bob_copy = bob
bob == bob_copy



#WE CAN OVERRIDE THIS IN OUR OWN CLASSES
class Person
  attr_accessor :name


# with this implementation, when we compare two Person objects, we'll
# be comparing their name variables and not their literal class objects
  def ==(other)
    name == other.name
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

# p bob == bob2
# p bob != bob2


#=== METHOD
# documentation states that using this methid is effectively the same as
# using the == method, but that the === method is typically overridden
# by descendants to be more situationally effective in case statements

(0..50) === 25
(0..50) == 25
