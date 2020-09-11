class Transform
  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end



my_data = Transform.new('abc')
# we need an initialize method that takes one argument as a parameter

puts my_data.uppercase
# we need an instance method that will take an object and uppercase it

puts Transform.lowercase('XYZ')
# we need a class method that will take a provided argument and lowercase it


