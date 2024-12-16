# frozen_string_literal: true

# Day 12
class Solution
  class Grid
    include Enumerable

    Coord = Data.define(:x, :y) do
      def +(other) = Coord.new(x + other.x, y + other.y)
      def all_orthogonal
        [
          self + Coord.new(0, -1),
          self + Coord.new(0, 1),
          self + Coord.new(-1, 0),
          self + Coord.new(1, 0)
        ]
      end

      def adjacent?(other)
        all_orthogonal.include?(other)
      end
    end

    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def each(&block)
      height.times do |y|
        width.times do |x|
          block.call(Coord.new(x, y))
        end
      end
    end

    def height = lines.length
    def width = lines.first.length

    def [](coord)
      return nil unless in_bounds?(coord)

      lines[coord.y][coord.x]
    end
    
    def in_bounds?(coord)
      coord.x >= 0 && coord.y >= 0 && coord.x < width && coord.y < height
    end
  end

  def part_one(lines)
    grid = Grid.new(lines)
    seen = Set.new
    result = 0
    grid.each do |coord|
      next if seen.include?(coord)

      stack = [coord]
      area = 0
      perimeter = 0
      value = grid[coord]
      while(current = stack.pop)
        next if seen.include?(current)

        seen << current
        area += 1
        current.all_orthogonal.each do |border|
          if grid[border] == value
            stack << border
          else
            perimeter += 1
          end
        end
      end
      result += (area * perimeter)
    end
    result
  end
  
  def part_two(lines)
    grid = Grid.new(lines)
    seen = Set.new
    result = 0
    grid.each do |coord|
      next if seen.include?(coord)

      queue = [coord]
      area = 0
      sides = 0
      surround = Array.new(4) { Set.new }
      value = grid[coord]
      while(current = queue.pop)
        next if seen.include?(current)

        seen << current
        area += 1
        current.all_orthogonal.each_with_index do |border, dir|
          if grid[border] == value
            queue.unshift(border)
          else
            sides += 1 if surround[dir].none? { |x| border.adjacent?(x) }
            surround[dir] << border
          end
        end
      end
      result += (area * sides)
    end
    result
  end
end
