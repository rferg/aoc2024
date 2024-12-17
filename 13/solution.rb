# frozen_string_literal: true

# Day 13
class Solution
  
  Vec = Struct.new(:x, :y) do
    def self.zero = new(0, 0)   
  end

  Machine = Struct.new(:a, :b, :prize) do
    def self.zero = new(Vec.zero, Vec.zero, Vec.zero)
      
    def solved?
      (a_times % 1).zero? && (b_times % 1).zero?
    end

    def a_times
      @a_times ||= (b.y * prize.x - b.x * prize.y) / (b.y * a.x - b.x * a.y).to_f
    end

    def b_times
      @b_times ||= (prize.y - a.y * a_times) / b.y.to_f
    end
  end

  def part_one(lines)
    parse(lines).sum do |machine|
      if machine.solved?
        (machine.a_times * 3 + machine.b_times).to_i
      else
        0
      end
    end
  end
  
  def part_two(lines)
    translation = 10000000000000
    parse(lines).sum do |machine|
      machine.prize.x += translation
      machine.prize.y += translation
      if machine.solved?
        (machine.a_times * 3 + machine.b_times).to_i
      else
        0
      end
    end
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
