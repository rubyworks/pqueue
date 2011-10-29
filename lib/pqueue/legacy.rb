# PQueue, a Priority Queue with array based heap.
#
# A priority queue is like a standard queue, except that each inserted
# elements is given a certain priority, based on the result of the
# comparison block given at instantiation time. Also, retrieving an element
# from the queue will always return the one with the highest priority
# (see #pop and #top).
#
# The default is to compare the elements in repect to their #> method.
# For example, Numeric elements with higher values will have higher
# priorities.
#
class PQueue

  # number of elements
  attr_reader :size
  # compare Proc
  attr_reader :gt
  attr_reader :qarray #:nodoc:
  protected :qarray

  # Returns a new priority queue.
  #
  # If elements are given, build the priority queue with these initial
  # values. The elements object must respond to #to_a.
  #
  # If a block is given, it will be used to determine the priority between
  # the elements.
  #
  # By default, the priority queue retrieves maximum elements first
  # (using the #> method).
  def initialize(elements=nil, &block) # :yields: a, b
    @qarray = [nil]
    @size = 0
    @gt = block || lambda {|a,b| a > b}
    replace(elements) if elements
  end

  private

  # Assumes that the tree is a heap, for nodes < k.
  #
  # The element at index k will go up until it finds its place.
  def upheap(k)
    k2 = k.div(2)
    v = @qarray[k]
    while k2 > 0 && @gt[v, @qarray[k2]]
      @qarray[k] = @qarray[k2]
      k = k2
      k2 = k2.div(2)
    end
    @qarray[k] = v
  end

  # Assumes the entire tree is a heap.
  #
  # The element at index k will go down until it finds its place.
  def downheap(k)
    v = @qarray[k]
    q2 = @size.div(2)
    loop {
      break if k > q2
      j = 2 * k
      if j < @size && @gt[@qarray[j+1], @qarray[j]]
        j += 1
      end
      break if @gt[v, @qarray[j]]
      @qarray[k] = @qarray[j]
      k = j
    }
    @qarray[k] = v;
  end


  # Recursive version of heapify. I kept the code, since it may be
  # easier to understand than the non-recursive one.
  #  def heapify
  #    @size.div(2).downto(1) {|i| h(i)}
  #  end
  #  def h(t)
  #    l = 2 * t
  #    r = l + 1
  #    hi = if r > @size || @gt[@qarray[l],@qarray[r]] then l else r end
  #    if @gt[@qarray[hi],@qarray[t]]
  #      @qarray[hi], @qarray[t] = @qarray[t], @qarray[hi]
  #      h(hi) if hi <= @size.div(2)
  #    end
  #  end

  # Make a heap out of an unordered array.
  def heapify
    @size.div(2).downto(1) do |t|
      begin
        l = 2 * t
        r = l + 1
        hi = if r > @size || @gt[@qarray[l],@qarray[r]] then l else r end
        if @gt[@qarray[hi],@qarray[t]]
          @qarray[hi], @qarray[t] = @qarray[t], @qarray[hi]
          if hi <= @size.div(2)
            t = hi
            redo
          end # if
        end #if
      end #begin
    end # downto
  end

  public

  # Add an element in the priority queue.
  #
  # The insertion time is O(log n), with n the size of the queue.
  def push(v)
    @size += 1
    @qarray[@size] = v
    upheap(@size)
    return self
  end

  alias :<< :push

  # Return the element with the highest priority and remove it from
  # the queue.
  #
  # The highest priority is determined by the block given at instanciation
  # time.
  #
  # The deletion time is O(log n), with n the size of the queue.
  #
  # Return nil if the queue is empty.
  def pop
    return nil if empty?
    res = @qarray[1]
    @qarray[1] = @qarray[@size]
    @size -= 1
    downheap(1)
    return res
  end

  # Return the element with the highest priority.
  def top
    return nil if empty?
    return @qarray[1]
  end

  # Add more than one element at the same time. See #push.
  #
  # The elements object must respond to #to_a, or to be a PQueue itself.
  def push_all(elements)
    if empty?
      if elements.kind_of?(PQueue)
        initialize_copy(elements)
      else
        replace(elements)
      end
    else
      if elements.kind_of?(PQueue)
        @qarray[@size + 1, elements.size] = elements.qarray[1..-1]
        elements.size.times{ @size += 1; upheap(@size)}
      else
        ary = elements.to_a
        @qarray[@size + 1, ary.size] = ary
        ary.size.times{ @size += 1; upheap(@size)}
      end
    end
    return self
  end

  alias :merge :push_all


  # Return top n-element as a sorted array.
  def pop_array(n=@size)
    ary = []
    n.times{ary.push(pop)}
    return ary
  end


  # True if there is no more elements left in the priority queue.
  def empty?
    return @size.zero?
  end

  # Remove all elements from the priority queue.
  def clear
    @qarray.replace([nil])
    @size = 0
    return self
  end

  # Replace the content of the heap by the new elements.
  #
  # The elements object must respond to #to_a, or to be a PQueue itself.
  def replace(elements)
    if elements.kind_of?(PQueue)
      initialize_copy(elements)
    else
      @qarray.replace([nil] + elements.to_a)
      @size = @qarray.size - 1
      heapify
    end
    return self
  end

  # Return a sorted array, with highest priority first.
  def to_a
    old_qarray = @qarray.dup
    old_size = @size
    res = pop_array
    @qarray = old_qarray
    @size = old_size
    return res
  end

  alias :sort :to_a

  # Replace the top element with the given one, and return this top element.
  #
  # Equivalent to successively calling #pop and #push(v).
  def replace_top(v)
    # replace top element
    if empty?
      @qarray[1] = v
      @size += 1
      return nil
    else
      res = @qarray[1]
      @qarray[1] = v
      downheap(1)
      return res
    end
  end

  # Return true if the given object is present in the queue.
  def include?(element)
    return @qarray.include?(element)
  end

  # Iterate over the ordered elements, destructively.
  def each_pop #:yields: popped
    until empty?
      yield pop
    end
    return nil
  end

  # Pretty print
  def inspect
    "<#{self.class}: size=#{@size}, top=#{top || "nil"}>"
  end

  ###########################
  ### Override Object methods

  # Return true if the queues contain equal elements.
  def ==(other)
    return size == other.size && to_a == other.to_a
  end

  private

  def initialize_copy(other)
    @gt = other.gt
    @qarray = other.qarray.dup
    @size = other.size
  end
end # class PQueue

