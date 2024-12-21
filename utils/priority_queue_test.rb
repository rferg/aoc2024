# frozen_string_literal: true

require_relative 'priority_queue'
require_relative 'test'

class PriorityQueueTest < Test
  def test_empty_is_true_on_initialize
    q = PriorityQueue.new
    assert(q.empty?)
  end

  def test_empty_is_false_when_has_elementes
    q = PriorityQueue.new
    q << 1
    assert(!q.empty?)
  end

  def test_empty_is_true_when_all_elements_popped
    q = PriorityQueue.new
    q << 1
    q << 2
    q.pop
    q.pop
    assert(q.empty?)
  end

  def test_pop_returns_nil_when_empty
    q = PriorityQueue.new
    assert_nil(q.pop)
  end

  def test_pops_in_correct_order
    q = PriorityQueue.new
    q << 5
    q << 1
    q << 3
    q << 2
    q << 4
    5.times { |i| assert_equal(i + 1, q.pop) }
  end

  def test_pops_in_correct_order_when_adds_interleaved
    q = PriorityQueue.new
    q << 0
    q << 9
    q << 2
    assert_equal(q.pop, 0)
    q << 1
    assert_equal(q.pop, 1)
    q << 13
    assert_equal(q.pop, 2)
    assert_equal(q.pop, 9)
  end

  def test_uses_custom_comparer
    q = PriorityQueue.new { |a, b| a.even? ? (b.even? ? a <=> b : -1) : (b.even? ? 1 : a <=> b) }
    5.times { q << _1 }
    assert_equal(q.pop, 0)
    assert_equal(q.pop, 2)
    assert_equal(q.pop, 4)
    assert_equal(q.pop, 1)
    assert_equal(q.pop, 3)
  end

  def test_include_is_true_when_value_in_queue
    q = PriorityQueue.new
    q << 0
    q << 2
    assert(q.include?(2))
  end

  def test_include_is_false_when_value_not_in_queue
    q = PriorityQueue.new
    assert(!q.include?(2))
  end
end