# frozen_string_literal: true

class SolutionBase
  def solve(_lines)
    raise NoMethodError, 'must implement solve'
  end
end