class Ancestors; end

class Humans < Ancestors
  def hello
    "ancestors class"
  end
end

class Persons < Humans
  def who_am_i
    puts "I am the #{bob.class.hello}"
    # I am the ancestors class
  end
end

bob = Persons.new
bob.who_am_i

# 1. Working only within the Ancestors class, modify the code
#    so that it prints "I am the ancestors class"