# frozen_string_literal: true

# Day 11
class Solution
  def part_one(lines)
    nums = lines.first.split(' ').map(&:to_i)
    25.times do
      nums = blink(nums)
    end
    nums.length
  end
  
  def part_two(lines)
    # TODO
  end

  def blink(nums)
    result = []
    nums.each do |n|
      if n.zero?
        result << 1
      elsif (s = n.to_s).length.even?
        half = s.length / 2
        result << s[...half].to_i
        result << s[half..].to_i
      else
        result << (n * 2024)
      end
    end
    result
  end
end
