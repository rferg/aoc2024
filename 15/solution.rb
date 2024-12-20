# frozen_string_literal: true

# Day 15
class Solution
  Coord = Data.define(:x, :y) do
    def +(other) = Coord.new(x + other.x, y + other.y)
  end

  DIRS = {
    "<" => Coord.new(-1, 0),
    ">" => Coord.new(1, 0),
    "v" => Coord.new(0, 1),
    "^" => Coord.new(0, -1)
  }.freeze

  class Grid
    include Enumerable

    attr_reader :lines

    def initialize(lines)
      @lines = lines
      self.robot = find { |coord| self[coord] == "@" }
    end

    def each(&block)
      height.times do |y|
        width.times do |x|
          block.call(Coord.new(x, y))
        end
      end
    end

    def move(char)
      dir = DIRS[char]
      raise "Unknown direction #{char}" if dir.nil?

      target = robot + dir
      if open?(target)
        move_robot(target)      
      elsif box?(target)
        move_box(target, dir)
      end
    end

    def boxes
      select { |coord| box?(coord) }
    end

    def to_s
      height.times.map do |y|
        width.times.map do |x|
          self[Coord.new(x, y)]
        end.join
      end.join("\n")
    end

    private

    def height = lines.length
    def width = lines.first.length
        
    def [](coord)
      return nil unless in_bounds?(coord)

      lines[coord.y][coord.x]
    end

    def []=(coord, value)
      return unless in_bounds?(coord)

      lines[coord.y][coord.x] = value
    end

    def obstacle?(coord) = self[coord] == "#"
    def box?(coord) = self[coord] == "O"
    def open?(coord) = self[coord] == "."

    def move_robot(to)
      self[robot] = "."
      self[to] = "@"
      self.robot = to
    end

    def move_box(target, dir)
      current = target
      boxes = []
      while (box?(current))
        boxes << current
        current += dir
      end

      if open?(current)
        self[current] = "O"
        move_robot(target)
      end
    end
    
    def in_bounds?(coord)
      coord.x >= 0 && coord.y >= 0 && coord.x < width && coord.y < height
    end

    attr_accessor :robot
  end

  class DoubleGrid < Grid    
    def initialize(lines)
      super(double_lines(lines))
    end

    def box_lefts
      select { |coord| self[coord] == "[" }
    end

    private

    def double_lines(lines)
      lines.map do |line|
        line.chars.map do |c|
          if c == "O"
            "[]"
          elsif c == "#"
            "##"
          elsif c == "."
            ".."
          elsif c == "@"
            "@."
          else
            c
          end
        end.join
      end
    end

    def box?(coord) = self[coord] == "[" || self[coord] == "]"
    
    def move_box(target, dir)
      boxes = Set.new
      queue = [target]
      surround = Set.new
      while (current = queue.pop)
        next if boxes.include?(current) || surround.include?(current)

        if box?(current)
          boxes << current
          queue.unshift(current + dir)
          other_dir = self[current] == "[" ? DIRS[">"] : DIRS["<"]
          queue.unshift(current + other_dir) unless other_dir == dir
        else
          surround << current
        end
      end

      if surround.all? { |coord| open?(coord) }
        new_boxes = boxes.map { [_1 + dir, self[_1]] }
        (boxes - new_boxes.map(&:first)).each { self[_1] = "." }
        new_boxes.each { |coord, char| self[coord] = char }
        move_robot(target)
      end
    end
  end

  def part_one(lines)
    grid_lines, moves = parse(lines)
    grid = Grid.new(grid_lines)
    moves.each { |dir| grid.move(dir) }
    grid.boxes.sum { |coord| (100 * coord.y) + coord.x }
  end
  
  def part_two(lines)
    grid_lines, moves = parse(lines)
    grid = DoubleGrid.new(grid_lines)
    moves.each { |dir| grid.move(dir) }
    grid.box_lefts.sum { |coord| (100 * coord.y) + coord.x }
  end

  def parse(lines)
    grid_lines = []
    grid_end = false
    moves = []
    lines.each do |line|
      if line.empty?
        grid_end = true
      elsif grid_end
        moves += line.chars
      else
        grid_lines << line
      end
    end
    [grid_lines, moves]
  end
end
