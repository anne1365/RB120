
begin
  # code at risk of failing here
rescue StandardError => e   # storing the exception object in e
  puts e.message            # output error message
end

puts e.class 
# according to the article this code should yield 'TypeError', but it produces 'NilClass' - why?


def validate_age(age)
  raise("invalid age") unless (0..105).include?(age)
end
# a RuntimeError will be raised here because no other error type is specified

begin
  validate_age(age)
rescue RuntimeError => e
  puts e.message  # => invalid age
end

validate_age(456) # => NameError undefined local variable or method 'age'