# frozen_string_literal: true

# Day 7
class Solution
  def part_one(lines)
    parse(lines).sum { |target, nums| compute_result(target, nums, %i[+ *]) }
  end
  
  def part_two(lines)
    parse(lines).sum { |target, nums| compute_result(target, nums, %i[+ * concat]) }
  end

  def compute_result(target, nums, ops)
    perms = ops.repeated_permutation(nums.length - 1).to_a
    while (perm = perms.pop)
      perm_idx = -1
      result = nums.reduce do |acc, n|
        perm_idx += 1
        op = perm[perm_idx]
        if op == :concat
          concat(acc, n)
        else
          acc.public_send(op, n)
        end
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

  def concat(i, j)
    [i, j].join.to_i # :shrug
  end
end
