# frozen_string_literal: true

class SolutionBase
  attr_reader :lines

  def initialize(lines)
    @lines = lines
  end

  def solve
    raise NoMethodError, 'must implement solve'
  end
end