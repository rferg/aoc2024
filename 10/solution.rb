# frozen_string_literal: true

# Day 10
class Solution
  class Grid
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
    end

    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def zeros
      @zeros ||= begin
        z = []
        height.times do |y|
          width.times do |x|
            coord = Coord.new(x, y)
            z << coord if self[coord] == '0'
          end
        end
        z
      end
    end

    def height = lines.length
    def width = lines.first.length

    def [](coord)
      return nil unless in_bounds?(coord)

      lines[coord.y][coord.x]
    end

    def all_orthogonal(coord) = coord.all_orthogonal.select { |c| in_bounds?(c) }
    
    def in_bounds?(coord)
      coord.x >= 0 && coord.y >= 0 && coord.x < width && coord.y < height
    end
  end

  def part_one(lines)
    grid = Grid.new(lines)
    grid.zeros.sum { |c| reachable_nines_from(c, grid) }
  end
  
  def part_two(lines)
    grid = Grid.new(lines)
    grid.zeros.sum { |c| rating(c, grid) }
  end

  def rating(start, grid)
    count = 0
    stack = [start]
    while (current = stack.pop)
      value = grid[current]&.to_i
      next if value.nil?

      if value == 9
        count += 1
        next
      end

      stack += grid.all_orthogonal(current)
                   .select { |c| grid[c]&.to_i == value + 1 }
    end
    count
  end

  def reachable_nines_from(start, grid)
    count = 0
    stack = [start]
    seen = Set.new
    while (current = stack.pop)
      next if seen.include?(current)

      seen << current
      value = grid[current]&.to_i
      next if value.nil?

      if value == 9
        count += 1
        next
      end

      stack += grid.all_orthogonal(current)
                   .select { |c| grid[c]&.to_i == value + 1 }
    end
    count
  end
end
