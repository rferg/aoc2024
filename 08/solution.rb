# frozen_string_literal: true

# Day 8
class Solution
  class Grid
    Coord = Data.define(:x, :y) do
      def -(other) = Coord.new(x - other.x, y - other.y)
      def +(other) = Coord.new(x + other.x, y + other.y)
      def *(n) = Coord.new(x * n, y * n)
    end

    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def height = lines.length
    def width = lines.first.length
    
    def in_bounds?(coord)
      coord.x >= 0 && coord.y >= 0 && coord.x < width && coord.y < height
    end

    def [](coord)
      return nil unless in_bounds?(coord)

      lines[coord.y][coord.x]
    end

    def antinodes(&block)
      raise "block required" unless block_given?

      antennae.values
              .map { |coords| coords.combination(2).map(&block) }
              .flatten
              .select { |coord| in_bounds?(coord) }
              .uniq
    end

    def antennae
      @antennae ||= begin
        a = {}
        height.times do |y|
          width.times do |x|
            coord = Coord.new(x, y)
            next if self[coord] == "."
            
            (a[self[coord]] ||= []) << coord
          end
        end
        a
      end
    end
  end

  def part_one(lines)
    Grid.new(lines).antinodes { |a, b| [b - (a - b), a + (a - b)] }.length
  end
  
  def part_two(lines)
    grid = Grid.new(lines)
    max_dim = [grid.height, grid.width].max
    grid.antinodes do |a, b|
      diff = a - b
      max_dim.times.flat_map { |factor| [b - (diff * factor), a + (diff * factor)] }
    end.length
  end
end
