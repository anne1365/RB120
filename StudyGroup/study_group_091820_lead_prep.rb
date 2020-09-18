=begin
  -------------------------------------THE MAIN CONCEPTS-------------------------------------
    LOCAL VARIABLE SCOPE - 
      - The main rule: A variable initialized in an outer scope is avaialable within an inner
        scope, but a variable initialized in an inner scope isn't available in an outer scope.
      - A variable initialized outside of a *block* can be reassigned within a block.
        --> One gotcha --> VARIABLE SHADOWING
      - A method definition can't access a variable initialized in an outer scope unless that
        variable is passed into the method as an argument.
      - A local variable initialized outside of a method definition can't be reassigned
        within the method definition unless the method is mutating.
  
  
    MUTATING & NON-MUTATING METHODS - 
      - CONCATENATION --> concatenation, (in ruby, '.concat' or '>>') is a mutating
        method that allows us to append a given argument to a string or collection object.

      - REASSIGNMENT  --> non-mutating - if we initialize a variable x and assign it to the
        integer object 3, then type the expression 'x = 4', we've assigned x to the integer
        object 4. x no longer points to the integer object 3. Reassignment changes the
        'binding' of a variable. 

      - INDEXED ASSIGNMENT --> mutating with respect to the collection on which it is called,
        however, the individual element that was reassigned now points to a different object.     
  

    WORKING WITH COLLECTIONS - 
      - EACH   - Iterates through each element of the collection on which it's called. When
        called with a block passed in, returns calling collection, accepts a block but
        disregards its return value.

      - MAP    - Iterates through each element of the collection on which it's called. When
        called with a block passed in, returns a new array of the block's return values.

      - SELECT - Iterates through each element of the collection on which it's called. When
        called with a block passed in, select returns a new collection object containing each
        element from the original collection for which the block returned a truthy value.                                
    
  
    VARIABLES AS POINTERS - 
      - Variables point to physical locations in memory.
      - When a destructive method is called on a mutable object, that object that the
        variable is pointing to is itself changed.
      - Immutable objects cannot be changed (in Ruby, numbers and Booleans are immutable).
  
  
    PUTS VS. RETURN - 
      - PUTS   --> When provided an argument, puts will print the argument to the console as a
        string followed by a newline character. If the given argument isn't a string, puts
        will call the to_s method on the object before printing it. When called without an
        argument, puts outputs one new line character. Puts always returns nil.

      - RETURN --> Every method call, block, and expression returns an object in Ruby, whether
        that return value is a meanigful value, the calling object, or nil.
          - EXPLICIT RETURN VALUE - What's returned by a line of code preceded by the return
            keyword.
          - IMPLICIT RETURN VALUE - What's returned automatically (without invocation of the 
            return keyword) by the last line of a block, method, or piece of code.
  
  
    FALSE VS. NIL & "TRUTHINESS" - FILL OUT
  
  
    METHOD DEFINITION & METHOD INVOCATION - FILL OUT

=end



#PROBLEMS FOR WRITTEN------------------------------------------------------------------------------

# FILL OUT


#INTERVIEW QUESTIONS-------------------------------------------------------------------------------

=begin
  Find the longest substring in alphabetical order.
  Example: the longest alphabetical substring in "asdfaaaabbbbcttavvfffffdf" is "aaaabbbbctt".
  There are tests with strings up to 10 000 characters long so your code will need to be efficient.
  The input will only consist of lowercase characters and will be at least one letter long.
  If there are multiple solutions, return the one that appears first.
=end


p longest('asd') == 'as'
p longest('nab') == 'ab'
p longest('abcdeapbcdef') == 'abcde'
p longest('asdfaaaabbbbcttavvfffffdf') == 'aaaabbbbctt'
p longest('asdfbyfgiklag'), 'fgikl'
p longest('z') == 'z'
p longest('zyba') == 'z'
p longest('lerbshnemkryfhigpzuwlzwrxtsofhqanjkgxkirjqtgxhhnfxplnfkqwppmhkhuakmgrbcryi') == 'fkqw'



# You are given an array (which will have a length of at least 3, but could be very large)
# containing integers. The array is either entirely comprised of odd integers or entirely
# comprised of even integers except for a single integer N. Write a method that takes the
# array as an argument and returns this "outlier" N.

# Examples
# [2, 4, 0, 100, 4, 11, 2602, 36]
# Should return: 11 (the only odd number)


# [160, 3, 1719, 19, 11, 13, -21]
# Should return: 160 (the only even number)
# =end