# frozen_string_literal: true

# Day 1
class Solution
  def part_one(lines)
    left, right = split_lists(lines)
    left.sort!
    right.sort!
    left.zip(right).sum { |l, r| (l - r).abs }
  end
  
  def part_two(lines)
    left, right = split_lists(lines)
    counts = right.tally
    left.sum { |l| l * (counts[l] || 0) }
  end

  private

  def split_lists(lines)
    left = []
    right = []
    lines.each do |line|
      left_num, right_num = line.split(/\s+/)
      left << left_num.to_i
      right << right_num.to_i
    end
    [left, right]
  end
end
