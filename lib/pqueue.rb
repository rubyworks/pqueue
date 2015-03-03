# Priority queue with array based heap.
#
# A priority queue is like a standard queue, except that each inserted
# elements is given a certain priority, based on the result of the
# comparison block given at instantiation time. Also, retrieving an element
# from the queue will always return the one with the highest priority
# (see #pop and #top).
#
# The default is to compare the elements in repect to their #<=> method.
# For example, Numeric elements with higher values will have higher
# priorities.
#
# Note that as of version 2.0 the internal queue is kept in the reverse order
# from how it was kept in previous version. If you had used #to_a in the
# past then be sure to adjust for the priorities to be ordered back-to-front
# instead of the oterh way around.
#
class PQueue

  #
  VERSION = "2.1.0"  #:erb: VERSION = "<%= version %>"

  #
  # Returns a new priority queue.
  #
  # If elements are given, build the priority queue with these initial
  # values. The elements object must respond to #to_a.
  #
  # If a block is given, it will be used to determine the priority between
  # the elements. The block must must take two arguments and return `1`, `0`,
  # or `-1` or `true`, `nil` or `false. It should return `0` or `nil` if the
  # two arguments are considered equal, return `1` or `true` if the first
  # argument is considered greater than the later, and `-1` or `false` if
  # the later is considred to be greater than the first.
  #
  # By default, the priority queue retrieves maximum elements first
  # using the #<=> method.
  #
  def initialize(elements=nil, &block) # :yields: a, b
    @que = []
    @cmp = block || lambda{ |a,b| a <=> b }
    replace(elements) if elements
  end

 protected

  #
  # The underlying heap.
  #
  attr_reader :que #:nodoc:

 public

  #
  # Priority comparison procedure.
  #
  attr_reader :cmp

  #
  # Returns the size of the queue.
  #
  def size
    @que.size
  end

  #
  # Alias of size.
  #
  alias length size

  #
  # Add an element in the priority queue.
  #
  def push(v)
    @que << v
    reheap(@que.size-1)
    self
  end

  #
  # Traditional alias for #push.
  #
  alias enq push

  #
  # Alias of #push.
  #
  alias :<< :push

  #
  # Get the element with the highest priority and remove it from
  # the queue.
  #
  # The highest priority is determined by the block given at instantiation
  # time.
  #
  # The deletion time is O(log n), with n is the size of the queue.
  #
  # Return nil if the queue is empty.
  #
  def pop
    return nil if empty?
    @que.pop
  end

  #
  # Traditional alias for #pop.
  #
  alias deq pop

  # Get the element with the lowest priority and remove it from
  # the queue.
  #
  # The lowest priority is determined by the block given at instantiation
  # time.
  #
  # The deletion time is O(log n), with n is the size of the queue.
  #
  # Return nil if the queue is empty.
  #
  def shift
    return nil if empty?
    @que.shift
  end

  #
  # Returns the element with the highest priority, but
  # does not remove it from the queue.
  #
  def top
    return nil if empty?
    return @que.last
  end

  #
  # Traditional alias for #top.
  #
  alias peek top

  #
  # Returns the element with the lowest priority, but
  # does not remove it from the queue.
  #
  def bottom
    return nil if empty?
    return @que.first
  end

  #
  # Add more than one element at the same time. See #push.
  #
  # The elements object must respond to #to_a, or be a PQueue itself.
  #
  def concat(elements)
    if empty?
      if elements.kind_of?(PQueue)
        initialize_copy(elements)
      else
        replace(elements)
      end
    else
      if elements.kind_of?(PQueue)
        @que.concat(elements.que)
        sort!
      else
        @que.concat(elements.to_a)
        sort!
      end
    end
    return self
  end

  #
  # Alias for #concat.
  #
  alias :merge! :concat

  #
  # Return top n-element as a sorted array.
  #
  def take(n=@size)
    a = []
    n.times{a.push(pop)}
    a
  end

  #
  # Returns true if there is no more elements left in the queue.
  #
  def empty?
    @que.empty?
  end

  #
  # Remove all elements from the priority queue.
  #
  def clear
    @que.clear
    self
  end

  #
  # Replace the content of the heap by the new elements.
  #
  # The elements object must respond to #to_a, or to be
  # a PQueue itself.
  #
  def replace(elements)
    if elements.kind_of?(PQueue)
      initialize_copy(elements)
    else
      @que.replace(elements.to_a)
      sort!
    end
    self
  end

  #
  # Return a sorted array, with highest priority first.
  #
  def to_a
    @que.dup
  end

  #
  # Return true if the given object is present in the queue.
  #
  def include?(element)
    @que.include?(element)
  end

  #
  # Push element onto queue while popping off and returning the next element.
  # This is qquivalent to successively calling #pop and #push(v).
  #
  def swap(v)
    r = pop
    push(v)
    r
  end

  #
  # Iterate over the ordered elements, destructively.
  #
  def each_pop #:yields: popped
    until empty?
      yield pop
    end
    nil
  end

  #
  # Pretty inspection string.
  #
  def inspect
    "<#{self.class}: size=#{size}, top=#{top || "nil"}>"
  end

  #
  # Return true if the queues contain equal elements.
  #
  def ==(other)
    size == other.size && to_a == other.to_a
  end

 private

  #
  #
  #
  def initialize_copy(other)
    @cmp  = other.cmp
    @que  = other.que.dup
    sort!
  end

  #
  # The element at index k will be repositioned to its proper place.
  #
  # This, of course, assumes the queue is already sorted.
  #
  def reheap(k)
    return self if size <= 1

    que = @que.dup

    v = que.delete_at(k)
    i = binary_index(que, v)

    que.insert(i, v)

    @que = que

    return self
  end

  #
  # Sort the queue in accorance to the given comparison procedure.
  #
  def sort!
    @que.sort! do |a,b|
      case @cmp.call(a,b)
      when  0, nil   then  0
      when  1, true  then  1
      when -1, false then -1
      else
        warn "bad comparison procedure in #{self.inspect}"
        0
      end
    end
    self
  end

  #
  # Alias of #sort!
  #
  alias heapify sort!

  #
  def binary_index(que, target)
    upper = que.size - 1
    lower = 0

    while(upper >= lower) do
      idx  = lower + (upper - lower) / 2
      comp = @cmp.call(target, que[idx])

      case comp
      when 0, nil
        return idx
      when 1, true
        lower = idx + 1
      when -1, false
        upper = idx - 1
      else
      end
    end
    lower
  end

end # class PQueue
