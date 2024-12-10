# frozen_string_literal: true

# Day 4
class Solution
  DIRS = [
    [1, 0],
    [-1, 0], 
    [0, 1], 
    [0, -1],
    [1, -1],
    [1, 1],
    [-1, -1],
    [-1, 1]
  ].freeze

  class Grid
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def height = lines.length
    def width = lines.first.length
    
    def at(x, y)
      return nil if x < 0 || y < 0 || x >= width || y >= height

      (lines[y] || [])[x]
    end
  end

  def part_one(lines)
    count = 0
    grid = Grid.new(lines)
    grid.height.times do |y|
      grid.width.times do |x|
        char = grid.at(x, y)
        next if char != 'X'

        num_found = DIRS.count do |x_dir, y_dir|
          grid.at(x + x_dir, y + y_dir) == 'M' &&
            grid.at(x + x_dir * 2, y + y_dir * 2) == 'A' &&
            grid.at(x + x_dir * 3, y + y_dir * 3) == 'S'
        end
        count += num_found
      end
    end
    count
  end
  
  def part_two(lines)
    count = 0
    grid = Grid.new(lines)
    grid.height.times do |y|
      grid.width.times do |x|
        count += 1 if xmas?(x, y, grid)
      end
    end
    count
  end
  
  MAS = %w[MS SM].freeze

  def xmas?(x, y, grid)
    mid = grid.at(x, y)
    return false unless mid == 'A'

    diag1 = "#{grid.at(x + 1, y + 1)}#{grid.at(x - 1, y - 1)}"
    diag2 = "#{grid.at(x + 1, y - 1)}#{grid.at(x - 1, y + 1)}"
    MAS.include?(diag1) && MAS.include?(diag2)
  end
end
