# frozen_string_literal: true

# Day 6
class Solution
  class Grid
    Coord = Data.define(:x, :y) do
      def +(coord)
        Coord.new(x + coord.x, y + coord.y)
      end
    end

    module Dirs
      UP =    Coord.new(0, -1)
      RIGHT = Coord.new(1, 0)
      DOWN =  Coord.new(0, 1)
      LEFT =  Coord.new(-1, 0)
    end

    attr_reader :lines
    attr_accessor :current, :dir

    def initialize(lines)
      @lines = lines
      set_start
    end

    def height = lines.length
    def width = lines.first.length
    
    def [](coord)
      return nil unless in_bounds(coord)

      lines[coord.y][coord.x]
    end

    def set_start
      height.times do |y|
        width.times do |x|
          coord = Coord.new(x, y)
          next unless self[coord] == "^"

          self.current = coord
          self.dir = Dirs::UP
          return
        end
      end
      raise "Did not find '^'"
    end

    def run
      while (in_bounds(current))
        path << current
        next_coord = current + dir
        while(self[next_coord] == "#") do
          turn
          next_coord = current + dir
        end
        self.current = next_coord
      end
    end

    def turn
      if dir == Dirs::LEFT
        self.dir = Dirs::UP
      elsif dir == Dirs::UP
        self.dir = Dirs::RIGHT
      elsif dir == Dirs::RIGHT
        self.dir = Dirs::DOWN
      else
        self.dir = Dirs::LEFT
      end
    end

    def in_bounds(coord)
      coord.x >= 0 && coord.y >= 0 && coord.x < width && coord.y < height
    end

    def path
      @path ||= []
    end
  end

  def part_one(lines)
    grid = Grid.new(lines)
    grid.run
    grid.path.uniq.length
  end
  
  def part_two(lines)
    # TODO
  end
end
