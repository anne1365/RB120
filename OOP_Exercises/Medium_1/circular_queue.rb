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

 MENTAL MODEL: Given a buffer of size x, we want to add objects to the end of the buffer. When
 the buffer is full, we want to override the oldest data with the new data. For this, we need
 to know where the oldest data is, and we need to know what the next buffer slot holds. We also
 need to be continually aware of how large our buffer needs to be, and how any slot not filled
 should return nil.

 ALGORITHM: 
 - SETTING UP THE CLASS
   - the queue should be initialized as an array containing x number of nil objects
   - an instance variable `next_element` should be initialized to track the contents of the next
     buffer slot
   - an `oldest_element` will hold the oldest object in the buffer
 - ENQUEUE
   - if the next element is nil, we'll reassign the next element to the object and then increment
     the next element by one
   - if the next element is not nil, 
 
=end

class CircularQueue
  
  def initialize(size)
    @queue = [nil] * size
    @next_element = 0
    @oldest_element = 0
  end

  def enqueue(obj)
    p @queue[@next_element].nil?
    p @oldest_element
    p increment(@next_element)
    
    unless @queue[@next_element].nil?
      @oldest_element = increment(@next_element)
    end
    
    p @oldest_element
    
    @queue[@next_element] = obj
    @next_element = increment(@next_element)
  end

  def dequeue
    value = @queue[@oldest_element]
    @queue[@oldest_element] = nil
    # puts "Incrementing oldest element. Before #{@oldest_element} after #{increment(@oldest_element)}"
    @oldest_element = increment(@oldest_element) unless value.nil?
    value
  end

  private

  def increment(element)
    (element + 1) % @queue.size
  end
end

# class CircularQueue
#   def initialize(max_queue_size)
#     @max_queue_size = max_queue_size
#     @queue = []
#   end

#   def enqueue(obj)
#     dequeue if queue_full?
#     @queue << obj
#   end

#   def dequeue
#     @queue.shift
#   end

#   private

#   def queue_full?
#     @queue.size == @max_queue_size
#   end
# end

queue = CircularQueue.new(3)
# puts queue.dequeue == nil
queue
queue.enqueue(1)
p queue
queue.enqueue(2)
p queue
# puts queue.dequeue == 1
queue.enqueue(3)
queue.enqueue(4)
# puts queue.dequeue == 2
# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil


# queue = CircularQueue.new(4)
# puts queue.dequeue == nil
# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1
# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2
# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

