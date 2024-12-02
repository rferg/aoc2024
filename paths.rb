require "pathname"

module Paths
  class << self
    def day_dir(num)
      Pathname.new(num.to_s.rjust(2, "0"))
    end

    def input(day_dir_path)
      day_dir_path.join("input")
    end

    def solution(day_dir_path, num)
      day_dir_path.join("solution_part_#{num}.rb")
    end
  end
end