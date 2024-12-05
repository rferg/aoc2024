require_relative 'paths'

day = ARGV.first&.to_i || 0

raise "Invalid day input #{ARGV.first}. Usage: ruby setup_day.rb <day_number>" unless day.positive? && day <= 25

day_dir = Paths.day_dir(day)
solution_path = Paths.solution(day_dir)
input_path = Paths.input(day_dir)

if solution_path.exist? && input_path.exist?
  puts "All day #{day} files already exist."
  exit(0)
end

day_dir.mkdir unless day_dir.directory?

solution_template = <<~RUBY
  # frozen_string_literal: true

  # Day #{day}
  class Solution
    def part_one(lines)
      # TODO
    end
    
    def part_two(lines)
      # TODO
    end
  end
RUBY

input_path.write("") unless input_path.exist?
puts "Created empty input file."
solution_path.write(solution_template) unless solution_path.exist?
puts "Wrote #{solution_path}"

puts "Done"
exit(0)