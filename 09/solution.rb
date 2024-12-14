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
      buffer += Array.new(len, id)
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
    line = lines.first
    buffer = []
    file_length_ends = []

    line.chars.each_with_index do |c, i|
      id = i.even? ? i / 2 : nil
      len = c.to_i
      buffer += Array.new(len, id)
      file_length_ends[id] = [len, buffer.length] unless id.nil?
    end    

    file_length_ends.to_enum.with_index.reverse_each do |len_end, id|
      len, end_pos = len_end
      starts = end_pos - len
      current_pos = 0
      while(free_range = next_free_chunk(current_pos, buffer))
        break if starts < free_range.begin

        if free_range.size >= len
          buffer[free_range.begin...(free_range.begin + len)] = Array.new(len, id)
          buffer[(end_pos - len)...end_pos] = Array.new(len, nil)
          break
        end

        current_pos = free_range.end + 1
      end
    end
    buffer.length.times.sum { |i| buffer[i].nil? ? 0 : buffer[i] * i }
  end

  def next_free_chunk(start, buffer)
    nil_idx = buffer[start..].index(nil)&.+ start
    return nil if nil_idx.nil?

    non_nil_idx = nil_idx
    while (buffer[non_nil_idx].nil? && non_nil_idx <= buffer.length)
      non_nil_idx += 1
    end
    
    nil_idx...non_nil_idx
  end
end
