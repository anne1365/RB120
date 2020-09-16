class Person
  TITLES = ['Mr.', 'Mrs', 'Ms', 'Dr']

  attr_reader :name
  
  def self.titles
    TITLES.join(', ')
  end

  def initialize(n)
    @name = "#{TITLES.sample} #{n}"
  end

  def get_name
    @name
  end
end

Person.titles

bob = Person.new('bob')
bob.name

module A
  module B
    module D
      Module.nesting
    end
  end
end


LETTER = 'a'

class Cat
  COLOR = 'orange'
end

p LETTER
p Cat::COLOR
