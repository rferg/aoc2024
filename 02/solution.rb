# frozen_string_literal: true

# Day 2
class Solution
  class Row
    attr_reader :readings
  
    def initialize(readings)
      @readings = readings
    end
  
    def safe?
      last_diff = nil
      readings.each_cons(2).all? do |a, b|
        diff = a.to_i - b.to_i
        result = safe_diff?(diff, last_diff)
        last_diff = diff
        result
      end
    end

    def safe_diff?(diff, last_diff)
      (1..3).include?(diff.abs) && (last_diff.nil? || (diff * last_diff).positive?)
    end
  end

  def part_one(lines)
    lines.count { |line| Row.new(line.split(' ')).safe? }
  end
  
  def part_two(lines)
    lines.count do |line|
      readings = line.split(' ')
      Row.new(readings).safe? ||
        readings.length.times.any? do |i|
          Row.new(readings.reject.with_index { |_, j| i == j }).safe?
        end
    end
  end
end
