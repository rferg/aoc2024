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
  ]

  def part_one(lines)
    count = 0
    height = lines.length
    width = lines.first.length
    height.times do |y|
      width.times do |x|
        char = lines[y][x]
        next if char != 'X'

        num_found = DIRS.count do |x_dir, y_dir|
          x_extent = x + (x_dir * 3)
          y_extent = y + (y_dir * 3)

          x_extent >= 0 &&
            x_extent < width &&
            y_extent >= 0 &&
            y_extent < height &&
            lines[y + y_dir][x + x_dir] == 'M' &&
              lines[y + y_dir * 2][x + x_dir * 2] == 'A' &&
              lines[y_extent][x_extent] == 'S'
        end
        count += num_found
      end
    end
    count
  end
  
  def part_two(lines)
    # TODO
  end
end
