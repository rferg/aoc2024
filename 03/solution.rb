# frozen_string_literal: true

# Day 3
class Solution
  def part_one(lines)
    lines.sum { |line| multiply(line) }
  end
  
  def part_two(lines)
    active = true
    result = 0
    str = ''
    lines.each do |line|
      line.chars.each_with_index do |c, i|
        str += c if active
        if c == ')' && i >= 3 && line[(i - 3)..i] == 'do()'
          active = true
        elsif c == ')' && i >= 6 && line[(i - 6)..i] == "don't()"
          active = false
          result += multiply(str)
          str = ''
        end
      end
    end
    result += multiply(str) if active
    result
  end

  def multiply(str)
    matches = str.scan(/mul\((?<a>\d{1,3}),(?<b>\d{1,3})\)/)
    matches.sum { |a, b| a.to_i * b.to_i }
  end
end
