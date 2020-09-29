=begin
 PROBLEM: Write a class `CircularQueue` that implements a circular buffer. The class
 should obtain the buffer size upon creation of a new class instance, and the class
 should provide an `enqueue` method to add items to the queue, and a `dequeue` method
 to remove items from the queue.

 INPUTS: length of buffer, then objects to be stored in the buffer
 OUTPUTS: should be able to add objects to the buffer and remove oldest things from the buffer

 RULES: 
  - class needs to implement circular buffer
  - class must contain methods that add and remove objects from the buffer
  - when the buffer is full, oldest data must be removed to make way for new data (override)
  - our method to remove buffer items should return nil if buffer is empty

 QUESTIONS: 
  - What is a circular buffer? A collection of objects stored in a buffer that is
    treated as though is connected end-to-end like a circle
  - What are data structures that could be used to implement one? My first thought is
    an array
  - Should the circular buffer - when full - discard new incoming data, or override
    the oldest data with the new incoming data? It should override the oldest data

 EXAMPLES / TEST CASES: below

 MENTAL MODEL: 

 ALGORITHM:

=end

class CircularQueue
  
  def initialize(size)
    @queue = [nil] * size
    @next_element = 0
    @oldest_element = 0
  end

  def enqueue(obj)
    unless @queue[@next_element].nil?
      @oldest_element = increment(@next_element)
    end

    @queue[@next_element] = obj
    @next_element = increment(@next_element)
  end

  def dequeue
    value = @queue[@oldest_element]
    @queue[@oldest_element] = nil
    @oldest_element = increment(@oldest_element) unless value.nil?
    value
  end

  private

  def increment(element)
    (element + 1) % @queue.size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil