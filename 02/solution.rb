# frozen_string_literal: true

# Day 2
class Solution
  def part_one(lines)
    lines.count do |line|
      last_diff = nil
      line.split(' ').each_cons(2).all? do |a, b|
        diff = a.to_i - b.to_i
        result = (1..3).include?(diff.abs) && (last_diff.nil? || (diff.positive? && last_diff.positive?) || (diff.negative? && last_diff.negative?))
        last_diff = diff
        result
      end
    end
  end
  
  def part_two(lines)
    # TODO
  end
end
