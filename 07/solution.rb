# frozen_string_literal: true

# Day 7
class Solution
  def part_one(lines)
    pairs = parse(lines)
    pairs.sum { |target, nums| compute_result(target, nums) }
  end
  
  def part_two(lines)
    # TODO
  end

  def compute_result(target, nums)
    perms = [:+, :*].repeated_permutation(nums.length - 1).to_a
    while (perm = perms.pop)
      perm_idx = -1
      result = nums.reduce do |acc, n|
        perm_idx += 1
        acc.public_send(perm[perm_idx], n)
      end
      return target if result == target
    end
    0
  end

  def parse(lines)
    lines.map do |line|
      target, nums = line.split(": ")
      nums = nums.split(' ').map(&:to_i)
      [target.to_i, nums]
    end
  end
end
