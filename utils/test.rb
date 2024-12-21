# frozen_string_literal: true

class Test
  Error = Class.new(StandardError)

  def assert_nil(x)
    assert(x.nil?, "Expected #{x} to be nil")
  end

  def assert_equal(a, b)
    assert(a == b, "Expected #{a} to equal #{b}")
  end

  def assert(check, failure_message = "Expected truthy but was #{check}")
    raise Error.new(failure_message) unless check
  end
end