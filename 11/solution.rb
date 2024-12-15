# frozen_string_literal: true

# Day 11
class Solution
  def part_one(lines)
    map = {}
    cache = {}
    nums = numbers(lines)
    nums.length + nums.sum { |n| blink(n, 25, map, cache) }
  end
  
  def part_two(lines)
    map = {}
    cache = {}
    nums = numbers(lines)
    nums.length + nums.sum { |n| blink(n, 75, map, cache) }
  end

  def blink(n, iter, map, cache)
    return 0 if iter.zero?
    return cache[[n, iter]] unless cache[[n, iter]].nil?

    value = (map[n] ||= if n.zero?
                          [1]
                        elsif (s = n.to_s).length.even?
                          [s[...s.length / 2].to_i, s[s.length / 2..].to_i]
                        else
                          [n * 2024]
                        end)
    cache[[n, iter]] ||= (value.length - 1) + value.sum { |m| blink(m, iter - 1, map, cache) }
  end

  def numbers(lines)
    lines.first.split(' ').map(&:to_i)
  end
end
