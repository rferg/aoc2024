# frozen_string_literal: true

# Day 14
class Solution
  H = 103
  W = 101

  Vec = Data.define(:x, :y) do
    def +(other) = Vec.new(x + other.x, y + other.y)
    def *(n) = Vec.new(x * n, y * n)
    def %(other) = Vec.new(x % other.x, y % other.y)

    def quadrant
      mid_x = W / 2
      mid_y = H / 2
      return nil if x == mid_x || y == mid_y
      
      if x > mid_x
        y > mid_y ? 3 : 1
      else
        y > mid_y ? 2 : 0
      end
    end
  end

  DIM_VEC = Vec.new(W, H)

  class Robot
    attr_reader :pos, :movement

    def initialize(pos, movement)
      @pos = pos
      @movement = movement
    end

    def move(seconds)
      (pos + (movement * seconds)) % DIM_VEC
    end
  end

  def part_one(lines)
    seconds = 100
    parse(lines).map { |robot| robot.move(seconds) }
                .group_by(&:quadrant)
                .except(nil)
                .values
                .map(&:length)
                .reduce(:*)
  end
  
  def part_two(lines)
    # TODO
  end

  def parse(lines)
    lines.map do |line|
      p, v = line.split(' ')
      Robot.new(
        Vec.new(*p.split("=").last.split(",").map(&:to_i)),
        Vec.new(*v.split("=").last.split(",").map(&:to_i))
      )
    end
  end
end
