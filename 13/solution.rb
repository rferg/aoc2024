# frozen_string_literal: true

# Day 13
class Solution
  
  Vec = Struct.new(:x, :y) do
    def self.zero = new(0, 0)
      
    def +(other) = Vec.new(x + other.x, y + other.y)
    def *(n) = Vec.new(x * n, y * n)
    def ==(other) = other.x == x && other.y == y    
  end

  Machine = Struct.new(:a, :b, :prize) do
    def self.zero = new(Vec.zero, Vec.zero, Vec.zero)
      
    def solved?(a_times, b_times)
      ((a * a_times) + (b * b_times)) == prize
    end
  end

  def part_one(lines)
    # dumb brute force check
    max = 100
    parse(lines).sum do |machine|
      min_cost = 0
      max.times do |a|
        max.times do |b|
          next unless machine.solved?(a, b)
            
          solve_cost = a * 3 + b
          min_cost = solve_cost if min_cost.zero? || solve_cost < min_cost
        end
      end
      min_cost
    end
  end
  
  def part_two(lines)
    # TODO
  end

  def parse(lines)
    machines = []
    current = Machine.zero
    lines.each do |line|
      if line.empty?
        machines << current
        current = Machine.zero
        next
      end

      label, value = line.split(':')
      x, y = value.split(',').map { |a| a.split(/[+=]/).last.to_i }
      vec = Vec.new(x, y)
      if label.chars.last == "A"
        current.a = vec
      elsif label.chars.last == "B"
        current.b = vec
      else
        current.prize = vec
      end
    end
    machines << current
    machines
  end
end
