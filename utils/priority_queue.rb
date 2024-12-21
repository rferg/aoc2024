# frozen_string_literal: true

# Simple Binary Heap Priority Queue
class PriorityQueue
  def initialize(&comparer)
    @heap = []
    @comparer = comparer || Proc.new { |a, b| a <=> b }
  end

  def empty? = heap.empty?

  def pop
    return nil if empty?

    heap.shift.tap { sink(0) }
  end

  def <<(x)
    heap << x
    swim(heap.length - 1)
  end

  # This is slow, but should be fine.
  # Could instead keep a Set index of the heap.
  def include?(x) = heap.include?(x)

  private

  attr_reader :heap, :comparer

  def sink(i)
    loop do
      left = i * 2 + 1
      right = i * 2 + 2
      break if left >= heap.length

      smallest = right < heap.length && less?(right, left) ? right : left 
      break if less?(i, smallest)

      swap(smallest, i)
      i = smallest
    end
  end

  def swim(i)
    parent = (i - 1) / 2
    while (i > 0 && less?(i, parent))
      swap(parent, i)
      i = parent
      parent = (i - 1) / 2
    end
  end

  def swap(i, j)
    heap[i], heap[j] = heap[j], heap[i]
  end

  def less?(i, j)
    comparer.call(heap[i], heap[j]) == -1
  end
end