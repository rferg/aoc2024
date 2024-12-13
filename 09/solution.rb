# frozen_string_literal: true

# Day 9
class Solution
  def part_one(lines)
    line = lines.first
    buffer = []
    files_length = 0

    line.chars.each_with_index do |c, i|
      id = i.even? ? i / 2 : nil
      len = c.to_i
      len.times { buffer << id }
      files_length += len if i.even?
    end

    while((first_nil_index = buffer.find_index(nil)) < files_length)
      last_num_index = buffer.rindex { |x| !x.nil? }
      num = buffer[last_num_index]
      buffer[first_nil_index] = num
      buffer[last_num_index] = nil
    end

    files_length.times.sum { |i| buffer[i] * i }
  end
  
  def part_two(lines)
    # TODO
  end
end
