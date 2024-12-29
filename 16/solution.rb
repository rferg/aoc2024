# frozen_string_literal: true

require_relative '../utils/priority_queue'

# Day 16
class Solution
  def part_one(lines)
    grid = parse(lines)
    queue = PriorityQueue.new { |a, b| a.dist <=> b.dist }
    visited = Set.new
    queue << grid.start
    current = nil
    while(!queue.empty?)
      current = queue.pop

    end
    current.score
  end
  
  def part_two(lines)
    # TODO
  end

  def parse(lines)
    # TODO: RETURN GRID
  end
end
