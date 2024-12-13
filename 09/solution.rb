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
      while((nil_idx, non_nil_idx = next_free_chunk(current_pos, buffer)))
        puts "starts #{starts}, nil_idx: #{nil_idx}, non_nil_idx: #{non_nil_idx}, current_pos: #{current_pos}"
        break if starts < nil_idx

        if (nil_idx - non_nil_idx) >= len
          buffer[first_nil_index...(first_nil_index + len)] = Array.new(len, id)
          buffer[(end_pos - len)...end_pos] = Array.new(len, nil)
          break
        end

        current_pos = non_nil_idx
      end
    end

    puts buffer.map { |x| x.nil? ? "." : x.to_s }.join
    buffer.length.times.sum { |i| buffer[i].nil? ? 0 : buffer[i] * i }
  end

  def next_free_chunk(start, buffer)
    nil_idx = buffer[start..].find_index(nil)
    return nil if nil_idx.nil?

    non_nil_idx = nil_idx
    while (buffer[non_nil_idx].nil?)
      non_nil_idx += 1
    end
    
    [nil_idx, non_nil_idx]
  end
end
