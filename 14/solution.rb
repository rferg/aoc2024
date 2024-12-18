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
    attr_reader :current, :movement

    def initialize(pos, movement)
      @current = pos
      @movement = movement
    end

    def move(seconds)
      self.current = (current + (movement * seconds)) % DIM_VEC
    end

    private

    attr_writer :current
  end

  class Swarm
    attr_reader :robots

    def initialize(robots)
      @robots = robots
    end

    def move(seconds)
      robots.each { _1.move(seconds) }
    end

    def to_s
      x_index = robots.map(&:current).group_by(&:x).transform_values { |vs| Set.new(vs.map(&:y)) }
      H.times.map do |y|
        W.times.map do |x|
          if x_index[x]&.include?(y)
            "X"
          else
            "."
          end
        end.join
      end.join("\n")
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
    swarm = Swarm.new(parse(lines))
    s = 10000.times.map do |i|
      puts "#{i + 1}"
      swarm.move(1)
      [
        "=" * W,
        "#{i + 1}",
        "",
        swarm.to_s
      ].join("\n")
    end.join("\n")
    File.write("14/frames", s)
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
