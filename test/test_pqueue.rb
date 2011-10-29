require 'microtest'
require 'ae/legacy'

require 'pqueue'

class TC_PQueue < MicroTest::TestCase
  include AE::Legacy::Assertions

  ARY_TEST   = [2,6,1,3,8,15,0,-4,7,8,10]
  ARY_TEST_2 = [25,10,5,13,16,9,16,12]

  def test_initialize_empty
    PQueue.new
  end

  def test_initialize_single_element
    PQueue.new([3])
  end

  def test_initialize_multiple_elements
    PQueue.new(ARY_TEST)
  end

  def test_initialize_with_custom_comparison
    PQueue.new {|a,b| b<=>a}
    PQueue.new([3]) {|a,b| b<=>a}
    PQueue.new(ARY_TEST) {|a,b| b<=>a}
  end

  def test_top
    assert_equal(ARY_TEST.max, PQueue.new(ARY_TEST).top)
    assert_nil(PQueue.new.top)
  end

  def test_pop
    sorted_ary = ARY_TEST.sort
    q = PQueue.new(ARY_TEST)
    ARY_TEST.size.times do
      assert_equal(sorted_ary.pop, q.pop)
    end
    assert_equal(0, q.size)
    assert_nil(PQueue.new.pop)
  end

  def test_insertion
    q = PQueue.new(ARY_TEST)
    assert_equal(ARY_TEST.size, q.size)

    ret = q.push(24)
    assert_equal(q, ret)
    assert_equal(ARY_TEST.size+1, q.size)
  end

  def test_concat
    q = PQueue.new(ARY_TEST)

    ret = q.concat(ARY_TEST_2)
    assert_equal(q, ret)
    assert_equal(ARY_TEST.size+ARY_TEST_2.size, q.size)

    q = PQueue.new(ARY_TEST)
    r = PQueue.new(ARY_TEST_2)
    q.concat(r)
    assert_equal(ARY_TEST.size + ARY_TEST_2.size, q.size)
  end

  def test_clear
    q = PQueue.new(ARY_TEST).clear
    assert_equal(q, q.clear)
    assert_equal(0, q.size)
  end

  def test_replace
    q = PQueue.new(ARY_TEST)
    q.replace(ARY_TEST_2)
    assert_equal(ARY_TEST_2.size, q.size)

    q = PQueue.new(ARY_TEST)
    q.replace(PQueue.new(ARY_TEST_2))
    assert_equal(ARY_TEST_2.size, q.size)
  end

  def test_inspect
    assert_equal("<PQueue: size=#{ARY_TEST.size}, top=#{ARY_TEST.max}>",
                 PQueue.new(ARY_TEST).inspect)
  end

  def test_to_a
    q = PQueue.new(ARY_TEST)
    assert_equal(ARY_TEST.sort, q.to_a)
    q = PQueue.new(0..4)
    assert_equal([0,1,2,3,4], q.to_a)
  end

  def pop_array
    q = PQueue.new(ARY_TEST)
    assert_equal(ARY_TEST.sort.reverse[0..5], q.pop_array(5))
    q = PQueue.new(ARY_TEST)
    assert_equal(ARY_TEST.sort.reverse, q.pop_array)
  end

  def test_include
    q = PQueue.new(ARY_TEST + [21] + ARY_TEST_2)
    assert_equal(true, q.include?(21))

    q = PQueue.new(ARY_TEST - [15])
    assert_equal(false, q.include?(15))
  end

  def test_equal
    assert_equal(PQueue.new, PQueue.new)
    assert_equal(PQueue.new(ARY_TEST), PQueue.new(ARY_TEST.sort_by{rand}))
  end

  def test_swap
    q = PQueue.new
    assert_nil(q.swap(6))
    assert_equal(6, q.top)

    q = PQueue.new(ARY_TEST)
    h = PQueue.new(ARY_TEST)
    q.pop; q.push(11)
    h.swap(11)
    assert_equal(q, h)
  end

  def test_dup
    q = PQueue.new(ARY_TEST)
    assert_equal(q, q.dup)
  end

  def test_array_copied
    ary = ARY_TEST.dup
    q = PQueue.new(ary)
    q.pop
    assert_equal(ARY_TEST, ary)

    ary = ARY_TEST.dup
    q = PQueue.new
    q.replace(ary)
    q.pop
    assert_equal(ARY_TEST, ary)

    ary = ARY_TEST.dup
    q = PQueue.new([1])
    q.concat(ary)
    q.pop
    assert_equal(ARY_TEST, ary)

    q = PQueue.new(ARY_TEST)
    r = q.dup
    q.pop
    assert_not_equal(q, r)
  end
end

