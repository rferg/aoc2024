# frozen_string_literal: true

# Day 5
class Solution
  def part_one(lines)
    rules, updates = parse(lines)
    updates.select { |u| u.valid?(u, rules) }
           .sum { |u| u[u.length / 2] }
  end
  
  def part_two(lines)
    # TODO
  end

  def valid?(u, rules)
    u.length.times.none? { |i| u[(i + 1)..].any? { |later| rules[u[i]]&.include?(later) } }
  end

  def parse(lines)
    rules = {}
    updates = []
    reading_rules = true
    lines.each do |line|
      if reading_rules
        if line.empty?
          reading_rules = false
        else
          first, second = line.split('|').map(&:to_i)
          (rules[second] ||= Set.new) << first
        end
      else
        updates << line.split(',').map(&:to_i)
      end
    end
    [rules, updates]
  end
end
